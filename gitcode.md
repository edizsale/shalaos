NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINTS                                                                             sda      8:0    0   40G  0 disk                                                                                         ├─sda1   8:1    0 18,9G  0 part /                                                                                       ├─sda2   8:2    0    1K  0 part                                                                                         └─sda5   8:5    0  1,1G  0 part [SWAP]  


sudo apt install -y cloud-guest-utils && sudo swapoff -a && sudo parted /dev/sda --script rm 5 rm 2 && sudo growpart /dev/sda 1 && sudo resize2fs /dev/sda1 && df -h /
