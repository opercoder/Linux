1. ansible-core на Astra Linux нужна версия от 3.6, так как текущая 3.5
   #### Решение:  
   ``` bash
   apt install -y python3.7 python3-distutils
   update-alternatives --install /usr/bin/python3 python /usr/bin/python3.5 1
   update-alternatives --install /usr/bin/python3 python /usr/bin/python3.7 2
   update-alternatives --list python
   update-alternatives --config python
   ```
1. fatal: [1.18.19.23]: FAILED! => {"changed": false, "msg": "python3-apt must be installed and visible from /usr/bin/python3.7."}
   #### Решение:  
   ``` bash
   cd /usr/lib/python3/dist-packages
   sudo ln -s apt_inst.cpython-35m-x86_64-linux-gnu.so apt_inst.so
   sudo ln -s apt_pkg.cpython-35m-x86_64-linux-gnu.so apt_pkg.so
   ```
