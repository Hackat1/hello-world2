#!/bin/bash
if [ -e /etc/httpd ]; then exit 0; fi                                                           # Stops file from clobbering itself on system restart
yum -y install httpd mod_ssl                                                                    # Install apache and ssl support
systemctl start httpd                                                                           # Start apache
sed -i 's/^/#/g' /etc/httpd/conf.d/welcome.conf                                                 # Comment out welcome page
sed -i '151s/AllowOverride None/AllowOverride All/' /etc/httpd/conf/httpd.conf                  # Replace AllowOverride None with AllowOverride All in the httpd.conf file
mkdir /var/www/html/pages.dir                                                                   # Make new directory for additional webpages
echo "<html><body><h1>Hi there NTI300</h1><p><a href="pages.dir/page2.html">Page 2</a></p></body></html>" > /var/www/html/index.html  # Create custom welcome page
htpasswd -cb /usr/local/etc/.htpasswd Hack P@ssw0rd0!                                           # Create .htaccess with user Hack and standard password.
htpasswd -b /usr/local/etc/.htpasswd Hack1 P@ssw0rd0!                                           # Create user Hack1 with standard password
echo "AuthUserFile /usr/local/etc/.htpasswd" > /var/www/html/pages.dir/.htaccess                # Create .htaccess file
echo 'AuthName "Page2 Access"' >> /var/www/html/pages.dir/.htaccess                             # Concatenate to .htaccess
echo "AuthType Basic" >> /var/www/html/pages.dir/.htaccess                                      # Concatenate to .htaccess
echo "<Limit GET POST>" >> /var/www/html/pages.dir/.htaccess                                    # Concatenate to .htaccess
echo "require user Hack" >> /var/www/html/pages.dir/.htaccess                                   # Concatenate to .htaccess
echo "require user Hack1" >> /var/www/html/pages.dir/.htaccess                                  # Concatenate to .htaccess
echo "</Limit>" >> /var/www/html/pages.dir/.htaccess                                            # Concatenate to .htaccess
chmod 755 /var/www/html/pages.dir/.htaccess                                                     # Change .htaccess file permissions to 755
systemctl restart httpd                                                                         # Restart apache
echo '#!/bin/bash' > /root/updating_webpage.sh                                                  # Create the website updating shell script
echo 'time=$(date)' >> /root/updating_webpage.sh                                                # Make the variable time equal to $date
echo 'echo "<html><body><h1>Hi there, it is $time, how are you?</h1></body></html>" > /var/www/html/pages.dir/page2.html' >> /root/updating_webpage.sh # Create page 2 with time/date
chmod 755 /root/updating_webpage.sh                                                             # Change permissions to updating_webpage
echo '* * * * * /bin/echo "I am running updating_webpage.sh" | logger' > /root/up_web_cron      # Create file used in crontab. Also contains log message
echo '* * * * * /root/updating_webpage.sh' >> /root/up_web_cron                                 # Add updating_webpage.sh script
crontab /root/up_web_cron                                                                       # Create the cron job
