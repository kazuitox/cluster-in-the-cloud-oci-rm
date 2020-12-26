# 概要
本リポジトリは Cluster in the Cloud (https://github.com/clusterinthecloud/terraform) を OCI の Resource Manager でデプロイできるようにしたものです。

# Cluster in the Cloud とは
University of Bristol の Matt Williams さんが作成された Slurm を aws/gcp/oci でデプロイできる Terraform スクリプトです。
Slurm の Cloud Scheduling がセットアップされており、 Cloud 上にオンデマンド環境が簡単にデプロイできます。

# 使い方
## 1. 本リポジトリの zip ファイルをダウンロードします。
<img src="https://github.com/kazuitox/cluster-in-the-cloud-oci-rm/blob/main/images/Download_zip_file.png" width="50%" height="50%" align="center">

## 2. OCI にログインし、user_OCID をコピーします。
<img src="https://github.com/kazuitox/cluster-in-the-cloud-oci-rm/blob/main/images/OCI_Profile.png" width="50%" height="50%" border="1px">

<img src="https://github.com/kazuitox/cluster-in-the-cloud-oci-rm/blob/main/images/OCI_User_OCID.png" width="50%" height="50%" border="1px">

## 3. メニューから Resource Manager -> Stack を選択します。
<img src="https://github.com/kazuitox/cluster-in-the-cloud-oci-rm/blob/main/images/OCI_RM_Stack.png" width="50%" height="50%" border="1px">

## 4. デプロイするコンパートメントを選択します
<img src="https://github.com/kazuitox/cluster-in-the-cloud-oci-rm/blob/main/images/OCI_Compartment.png" width="30%" height="30%" border="1px">

## 5. Create Stack をクリック
<img src="https://github.com/kazuitox/cluster-in-the-cloud-oci-rm/blob/main/images/OCI_RM_Create_Stack.png" width="50%" height="50%" border="1px">


## 6. Stack Configuration で .zip file を選択し、"1." でダウンロードした zip ファイルをアップロードして Next をクリックする
<img src="https://github.com/kazuitox/cluster-in-the-cloud-oci-rm/blob/main/images/OCI_RM_Stack_Info.png" width="50%" height="50%" border="1px">

## 7. 


```
% vi ~/.ssh/citc.key
% chmod 600 ~/.ssh/citc.key
```

```
% ssh -i ~/.ssh/citc.key opc@<IP Address>
```

```
% ssh -i ~/.ssh/citc.key opc@<IP Address>
Last login: Sat Dec 26 14:57:06 2020 from <IP Address>
######################

Welcome to the cluster
Please now create users and define the number of nodes you want.

######################
[opc@mgmt ~]$
```

```
[opc@mgmt ~]$ vi limits.yaml
```

before
```
#VM.Standard2.1:
#  1: 1
#  2: 1
#  3: 1
```


after
```
VM.Standard2.1:
  1: 1
#  2: 1
#  3: 1
```

```
[opc@mgmt ~]$ finish
```

# 参考 URL
https://cluster-in-the-cloud.readthedocs.io
