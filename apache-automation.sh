yum -y install httpd mod_ssl                                                                    # Install apache and ssl support
systemctl start httpd                                                                           # Start apache
sed -i 's/^/#/g' /etc/httpd/conf.d/welcome.conf                                                 # Comment out welcome page
mkdir /var/www/html/pages.dir                                                                   # Make new directory for additional webpages
echo "<html><body><h1>Hi there NTI300</h1><p><a href="pages.dir/page2.html">Page 2</a></p></body></html>" > /var/www/html/index.html  # Create custom welcome page
echo "<html><body><h1>This is page two</h1></body></html>" > /var/www/html/pages.dir/page2.html # Create page two.
htpasswd -ci /usr/local/etc/.htpasswd Hack P@ssw0rd0!                                           # Create .htaccess with user Hack and standard password.
htpasswd -i /usr/local/etc/.htpasswd Hack P@ssw0rd0!                                            # Create user Hack1 with standard password
echo "AuthUserFile /usr/local/etc/.htpasswd AuthName "Page2 Access" AuthType Basic <Limit GET POST> require user Hack require user Hack1 </Limit>" > /var/www/html/pages.dir/.htaccess # Create .htaccess file
systemctl restart httpd                                                                         # Restart apache
