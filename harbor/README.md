https://goharbor.io/docs/2.0.0/install-config/download-installer/ 

# Docker install:
```bash
sudo apt update
sudo apt install ca-certificates curl gnupg -y
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
  https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
```

# Ins richtige Verzeichnis wechseln
cd /opt

# Datei mit wget herunterladen
sudo wget https://github.com/goharbor/harbor/releases/download/v2.14.0/harbor-offline-installer-v2.14.0.tgz

# Datei entpacken
sudo tar -xzf harbor-offline-installer-v2.14.0.tgz

# Generate a Certificate Authority Certificate

In a production environment, you should obtain a certificate from a CA. In a test or development environment, you can generate your own CA. To generate a CA certficate, run the following commands.

# 1. Generate a CA certificate private key.

```bash
openssl genrsa -out ca.key 4096
```

# 2 Generate the CA certificate.

Adapt the values in the -subj option to reflect your organization. If you use an FQDN to connect your Harbor host, you must specify it as the common name (CN) attribute.

```bash
openssl req -x509 -new -nodes -sha512 -days 3650 \
 -subj "/C=CN/ST=Beijing/L=Beijing/O=example/OU=Personal/CN=yourdomain.com" \
 -key ca.key \
 -out ca.crt
```

Generate a Server Certificate

The certificate usually contains a .crt file and a .key file, for example, yourdomain.com.crt and yourdomain.com.key.

# 1.Generate a private key.
```bash
openssl genrsa -out mom-io.com.key 4096
```

2. Generate a certificate signing request (CSR).

Adapt the values in the -subj option to reflect your organization. If you use an FQDN to connect your Harbor host, you must specify it as the common name (CN) attribute and use it in the key and CSR filenames.

```bash
openssl req -sha512 -new \
    -subj "/C=CN/ST=Beijing/L=Beijing/O=example/OU=Personal/CN=mom-io.com" \
    -key mom-io.com.key \
    -out mom-io.com.csr
```

3. Generate an x509 v3 extension file.

Regardless of whether you’re using either an FQDN or an IP address to connect to your Harbor host, you must create this file so that you can generate a certificate for your Harbor host that complies with the Subject Alternative Name (SAN) and x509 v3 extension requirements. Replace the DNS entries to reflect your domain.

```bash
sudo tee v3.ext > /dev/null <<EOF
authorityKeyIdentifier=keyid,issuer
basicConstraints=CA:FALSE
keyUsage = digitalSignature, nonRepudiation, keyEncipherment, dataEncipherment
extendedKeyUsage = serverAuth
subjectAltName = @alt_names

[alt_names]
DNS.1=mom-io.com
DNS.2=momo-io
DNS.3=harbor
EOF
```

4. Use the v3.ext file to generate a certificate for your Harbor host.

Replace the yourdomain.com in the CRS and CRT file names with the Harbor host name.

```bash
openssl x509 -req -sha512 -days 3650 \
    -extfile v3.ext \
    -CA ca.crt -CAkey ca.key -CAcreateserial \
    -in mom-io.com.csr \
    -out mom-io.com.crt
```

# Provide the Certificates to Harbor and Docker

After generating the ca.crt, yourdomain.com.crt, and yourdomain.com.key files, you must provide them to Harbor and to Docker, and reconfigure Harbor to use them.

1.Copy the server certificate and key into the certficates folder on your Harbor host.

```bash
mkdir -p /data/cert/
cp mom-io.com.crt /data/cert/
cp mom-io.com.key /data/cert/
```

2.Convert yourdomain.com.crt to yourdomain.com.cert, for use by Docker.

The Docker daemon interprets .crt files as CA certificates and .cert files as client certificates.
openssl x509 -inform PEM -in mom-io.com.crt -out mom-io.com.cert

3.Copy the server certificate, key and CA files into the Docker certificates folder on the Harbor host. You must create the appropriate folders first.

```bash
sudo mkdir -p /etc/docker/certs.d/mom-io.com/
cp mom-io.com.cert /etc/docker/certs.d/mom-io.com/
cp mom-io.com.key /etc/docker/certs.d/mom-io.com/
cp ca.crt /etc/docker/certs.d/mom-io.com/
```

If you mapped the default nginx port 443 to a different port, create the folder /etc/docker/certs.d/yourdomain.com:port, or /etc/docker/certs.d/harbor_IP:port.

4. Restart Docker Engine.
   ```bash
   systemctl restart docker
   ```

You might also need to trust the certificate at the OS level. See Troubleshooting Harbor Installation for more information.

The following example illustrates a configuration that uses custom certificates.

```bash
/etc/docker/certs.d/
    └── yourdomain.com:port
       ├── yourdomain.com.cert  <-- Server certificate signed by CA
       ├── yourdomain.com.key   <-- Server key signed by CA
       └── ca.crt               <-- Certificate authority that signed the registry certificate
```

#### Configure the Harbor YML File

sudo ./install.sh