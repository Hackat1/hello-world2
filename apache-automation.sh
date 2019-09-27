yum -y install httpd mod_ssl                                                          # Install apache and ssl support
systemctl start httpd                                                                 # Start apache
sed -i 's/^/#/g' /etc/httpd/conf.d/welcome.conf                                       # Comment out welcome page 
echo "<html><body><h1>Hi there NTI300</h1></body></html>" > /var/www/html/index.html  # Create custom welcome page
systemctl restart httpd                                                               # Restart apache
