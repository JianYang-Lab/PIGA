#!/bin/bash
# Download the required test dataset
expected_md5="7577da881db2a1ed477c39c9bb6f0788" 
if wget -c https://yanglab.westlake.edu.cn/data/1kcp/piga.test_data.tar.gz; then
    echo "Download successful."
else
    echo "Primary URL failed, trying backup URL."
    rm -f piga.test_data.tar.gz
    if wget -c https://lab-storage.oss-cn-hangzhou.aliyuncs.com/Pub_sharedata/wangyifei/piga.test_data.tar.gz; then
        echo "Download successful."
    else
        echo "Download failed."
        exit 1
    fi
fi
actual_md5=$(md5sum piga.test_data.tar.gz | awk '{print $1}')
if [ $actual_md5 = $expected_md5 ]; then
    echo "Checksum verification successful."
    tar -xzvf piga.test_data.tar.gz
else
    echo "Checksum verification failed."
    exit 1
fi