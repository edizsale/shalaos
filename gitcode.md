NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS                                                                             sda      8:0    0   40G  0 disk                                                                                         ├─sda1   8:1    0 18,9G  0 part /                                                                                       ├─sda2   8:2    0    1K  0 part                                                                                         └─sda5   8:5    0  1,1G  0 part [SWAP]  


sudo apt install -y cloud-guest-utils && sudo swapoff -a && sudo parted /dev/sda --script rm 5 rm 2 && sudo growpart /dev/sda 1 && sudo resize2fs /dev/sda1 && df -h /


sudo apt install -y cloud-guest-utils parted && sudo swapoff -a && sudo parted /dev/sda --script rm 5 rm 2 && sudo growpart /dev/sda 1 && sudo resize2fs /dev/sda1 && df -h /


sudo fallocate -l 2G /swapfile && sudo chmod 600 /swapfile && sudo mkswap /swapfile && sudo swapon /swapfile && sudo sed -i '/\sswap\s/d' /etc/fstab && echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab && swapon --show


sudo swapon --show && grep swapfile /etc/fstab

echo 'RESUME=none' | sudo tee /etc/initramfs-tools/conf.d/resume && sudo update-initramfs -u


cd ~ && sudo rm -rf shalaos-build && rm -f shalaos-build.tar.gz && gh release download v1 --repo edizsale/shalaos --pattern shalaos-build.tar.gz && tar xzf shalaos-build.tar.gz && cd shalaos-build && ./build.sh
