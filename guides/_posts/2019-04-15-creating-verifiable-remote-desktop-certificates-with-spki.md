---
title: "Creating Verifiable Remote Desktop Host Certificates with spki"
layout: post
tags: [openssl, spki, pki, windows, rdp]
author: "[Aram Akhavan](https://github.com/kaysond)"
assets: "/guides/assets/creating-verifiable-remote-desktop-host-certificates-with-spki/"
---
This guide will show you how to use `spki` to generate and deploy fully verifiable x509 certificates for accessing your hosts via remote desktop, eliminating the dreaded security warning.

## Setting up a PKI with CRL's
The first step is creating a Public Key Infrastructure with Certificate Revocation Lists. CRL's are used to verify that the Certificate Authority (CA) has not revoked the certificate your host is presenting. This guide is geared towards Linux users, but as `spki` and `openssl` are both cross-platform, it should work for other OSes with minor modifications.

### Serving a CRL over http
The easiest way to serve a CRL is over http. NB: this is one case where https should **not** be used, as the CRL of the http server would also have to be verified, and the CRL of its CA, and so on and so forth.

This needs to be set up in advance of creating your certificates, as the URI will be permanently encoded in the certificate. If you are accessing your remote hosts over the internet, you'll also want to make sure that your CRL Distribution Point is publicly accessible.

Symbolic links are a great way to serve multiple CRL's from the same subdomain, and also have a public location for your public CA certificates. If you plan on using the default `spki` configuration on a Linux distribution, you can use the following commands:

```
sudo mkdir /var/pki
sudo ln -s /root/ca/intermediate/certs/ /var/pki/certs
sudo ln -s /root/ca/intermediate/crl/intermediate.crl.der /var/pki/intermediate.crl
sudo ln -s /root/ca/crl/ca.crl.der /var/pki/root.crl
sudo ln -s /root/ca/certs/ca.cert.pem /root/intermediate/certs/root.cert.pem
```

Your directory structure will end up looking something like this:
```
administrator@fserver:~$ ll /var/pki
total 8.0K
drwxr-xr-x  2 root root 4.0K Apr  4 15:16 ./
drwxr-xr-x 17 root root 4.0K Mar 29 10:15 ../
lrwxrwxrwx  1 root root   31 Apr  4 15:15 certs -> /root/ca/intermediate/certs//
lrwxrwxrwx  1 root root   49 Apr  4 15:15 intermediate.crl -> /root/ca/intermediate/crl/intermediate.crl.der
lrwxrwxrwx  1 root root   26 Apr  4 15:16 root.crl -> /root/ca/crl/ca.crl.der
```

The following assumes you're using `apache2` as your http server. You can use any http server but obviously the precise configuration syntax will depend on what you use.
We'll use a `VirtualHost` to serve a subdomain called `pki.domain.com`. Add the following to a "site" configuration file `/etc/apache2/sites-available/pki.conf`
```
<VirtualHost *:80>
	ServerName pki.domain.com
	DocumentRoot /var/pki
	<Directory /var/pki>
		Allowoverride none
		Options FollowSymLinks
		Require all granted
	</Directory>
	<Directory /var/pki/certs>
		Options Indexes FollowSymLinks
	</Directory>
</VirtualHost>
```
(Don't forget to replace the `ServerName` with your actual domain name)
If you'd prefer not to use a subdomain, you can use an alias (e.g. `Alias /pki /var/pki/`) and put it in your existing host configuration.

Activate the site with `sudo a2ensite pki` and then restart apache2 `sudo systemctl restart apache2`

Before continuing with the PKI setup, ensure that this location (e.g. `pki.domain.com/certs/`) is accessible through a browser.

### Setting up the PKI
We'll use [`spki`](https://github.com/kaysond/spki) in this guide, but you can use anything to generate your PKI, including vanilla `openssl`. Grab the script from the [Github repo](https://github.com/kaysond/spki) and save it somewhere in your path, like `/usr/local/bin`.

Open the script in your favorite text editor, and set the following two variables based on your previous http server setup:
* `ROOT_CRL_DP='URI:http://pki.domain.com/root.crl'`
* `INTRMDT_CRL_DP='URI:http://pki.domain.com/intermediate.crl'`

Now run `spki init` to go through the process of setting up the PKI. You can watch an example asciicast [here](https://asciinema.org/a/238438).

This will create a Root CA and use it to sign an Intermediate CA. The Intermediate CA will then be used to actually sign your host certificates. The CRL's are also automatically generated and signed.

You'll want to make sure that the Intermediate Certificate has the correct CRL DP:
```
X509v3 CRL Distribution Points:
Full Name:
URI:http://pki.domain.com/root.crl   
```

If the CRL is not accessible, the verification step will fail. You'll want to correct that and re-verify the intermediate certificate before continuing: `spki verify-intermediate`

#### CA Security
**The Root CA private key should be stored offline in a safe place.** If that key is compromised, the entire PKI is compromised. If the Intermediate CA key is compromised, however, you can revoke it and generate a new one. Any attempts to verify certificates signed by your compromised intermediate key will fail upon checking the CRL.

## Creating certificates
Now we'll actually create the certificate that will be used by your Windows host.

Run `spki create server <hostname>` and follow the prompts. If you access the host over the internet using a domain, you can use a `subjectAltName` so that the certificate is valid for both your local computer name, and also the domain name. Use `spki create server <hostname> -SAN DNS:domain.com`.

Again, make sure that the certificate has the correct CRL DP:
```
X509v3 CRL Distribution Points:
Full Name:
URI:http://pki.domain.com/intermediate.crl   
```

## Deploying on Windows
The easiest way to import multiple certificates in Windows is by using the pkcs12 format. Run `spki export-pkcs12 <hostname>` to generate the `.p12` file. You'll have to supply an export password. Now copy that file over to your Windows host, and open up the certificate management tool (search for "Manage Computer Certificates"; or Win+R, `certlm.msc`, Ok). Import everything to your "Personal Store" by following the steps below.

![Windows P12 Import Wizard Step 0]({{ "import-wizard-0.png" | prepend: page.assets | relative_url }})

![Windows P12 Import Wizard Step 1]({{ "import-wizard-1.png" | prepend: page.assets | relative_url }})

![Windows P12 Import Wizard Step 2]({{ "import-wizard-2.png" | prepend: page.assets | relative_url }})

![Windows P12 Import Wizard Step 3]({{ "import-wizard-3.png" | prepend: page.assets | relative_url }})

After importing, you there will be three certificates in your Personal Store: Root CA, Intermediate CA, and host certificate. Move the Root CA to `Trusted Root Certification Authorities`=>`Certificates`. Move the Intermediate CA to `Trusted Intermediate Certification Authorities`=>`Certificates`. You can leave your host certificate  in the Personal Store.

If you double-click your host certificate in the Personal Store and click the Certification Path tab, you should see the entire path back to your Root CA.

![Certification Path]({{ "cert-path.png" | prepend: page.assets | relative_url }})

Finally, you need to tell remote desktop to use the new certificate. First, find the certificate's SHA1 Hash, or "Thumbprint" by checking its "Details" tab:

![SHA1 Thumbprint]({{ "thumbprint.png" | prepend: page.assets | relative_url }})

Copy that thumprint and open a command prompt with administrator privileges.

Run `wmic /namespace:\\root\cimv2\TerminalServices PATH Win32_TSGeneralSetting Set SSLCertificateSHA1Hash="THUMBPRINT"`, replacing THUMBPRINT with what you just copied.

You'll have to restart the service or host for this to take effect.

## Deploying on clients
In order to trust the newly deployed certificate, your clients will also need to trust the Root CA cert and Intermediate CA cert. If you used the symbolic links above to serve certificates, you should be able to download them simply by accessing `pki.domain.com/certs/root.cert.pem` and `pki.domain.com/certs/intermediate.cert.pem`. Repeat the import process from above, this time on the two certificate files, and place them in the same trusted CA stores. You can also import them by changing the file extension to `.crt` and opening the files.

## Deploying on Linux