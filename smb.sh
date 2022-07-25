#/bin/bash
sudo apt-get install samba samba-common
echo "启动项"
sudo /etc/init.d/samba restart
echo "启动项"
sudo /etc/init.d/samba-ad-dc restart

sudo nano /etc/samba/smb.conf