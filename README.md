# 概要
本リポジトリは Cluster in the Cloud (https://github.com/clusterinthecloud/terraform) を OCI の Resource Manager でデプロイできるようにしたものです。

# Cluster in the Cloud とは
University of Bristol の Matt Williams さんが作成された Slurm を aws/gcp/oci でデプロイできる Terraform スクリプトです。
Slurm の Cloud Scheduling がセットアップされており、Cloud を利用したオンデマンドクラスターが簡単にデプロイできます。

# 使い方
## 1. 本リポジトリの zip ファイルをダウンロードします。
<img src="https://github.com/kazuitox/cluster-in-the-cloud-oci-rm/blob/main/images/Download_zip_file.png" width="50%" height="50%" border="4px">

## 2. OCI にログインし、user_OCID をコピーします。
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



# 参考 URL
https://cluster-in-the-cloud.readthedocs.io
