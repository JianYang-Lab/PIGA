#!/bin/bash
# Download the required test dataset
expected_md5="e6305a2bcf76ebba3574f999d0c20b2b" 
if wget -c https://zenodo.org/records/18659653/files/piga.test_data.tar.gz?download=1; then
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
