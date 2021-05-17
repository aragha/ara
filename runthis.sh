if grep 'fastestmirror=true' "/etc/dnf/dnf.conf"; then
	echo "fastestmirror set to true"
else
	echo 'fastestmirror=true' | sudo tee -a /etc/dnf/dnf.conf
fi
if grep 'max_parallel_downloads=10' "/etc/dnf/dnf.conf"; then
	echo 'max parallel downloads set to 10'
else
	echo 'max_parallel_downloads=10' | sudo tee -a /etc/dnf/dnf.conf
fi
if grep 'deltarpm=true' "/etc/dnf/dnf.conf"; then
	echo 'delta rpm set to true'
else
	echo 'deltarpm=true' | sudo tee -a /etc/dnf/dnf.conf
fi	

#enable RPM Fusion repository
sudo rpm -Uvh http://download1.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm

dnf list installed | grep "firefox" > fc
if grep 'firefox' "./fc"; then
	echo 'firefox installed'
else
	sudo dnf install firefox --assumeyes
fi	
#rm ./fc

