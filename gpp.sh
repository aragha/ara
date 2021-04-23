#install g++ for Fedora Linux
sudo dnf update
sudo dnf install gcc-c++

#this is discoverable by doing 
sudo dnf install /usr/bin/g++

# or
dnf whatprovides '*/g++'

#for yacc
sudo dnf install byacc
