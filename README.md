# 概要
本リポジトリは Cluster in the Cloud (https://github.com/clusterinthecloud/terraform) を OCI の Resource Manager でデプロイできるようにしたものです。

# Cluster in the Cloud とは
University of Bristol の Matt Williams さんが作成された Slurm を aws/gcp/oci でデプロイできる Terraform スクリプトです。
Slurm の Cloud Scheduling がセットアップされており、 Cloud 上にオンデマンド環境が簡単にデプロイできます。

# 使い方
## 1. 本リポジトリの zip ファイルをダウンロード
<img src="https://github.com/kazuitox/cluster-in-the-cloud-oci-rm/blob/main/images/Download_zip_file.png" width="50%" height="50%" align="center">

## 2. OCI にログインし、user_OCID をコピー
<img src="https://github.com/kazuitox/cluster-in-the-cloud-oci-rm/blob/main/images/OCI_Profile.png" width="50%" height="50%" border="1px">

<img src="https://github.com/kazuitox/cluster-in-the-cloud-oci-rm/blob/main/images/OCI_User_OCID.png" width="50%" height="50%" border="1px">

## 3. メニューから Resource Manager -> Stack を選択
<img src="https://github.com/kazuitox/cluster-in-the-cloud-oci-rm/blob/main/images/OCI_RM_Stack.png" width="50%" height="50%" border="1px">

## 4. デプロイするコンパートメントを選択
<img src="https://github.com/kazuitox/cluster-in-the-cloud-oci-rm/blob/main/images/OCI_Compartment.png" width="30%" height="30%" border="1px">

## 5. Stack の作成
<img src="https://github.com/kazuitox/cluster-in-the-cloud-oci-rm/blob/main/images/OCI_RM_Create_Stack.png" width="50%" height="50%" border="1px">

Stack Configuration で .zip file を選択し、"1." でダウンロードした zip ファイルをアップロードして Next をクリックする
<img src="https://github.com/kazuitox/cluster-in-the-cloud-oci-rm/blob/main/images/OCI_RM_Stack_Info.png" width="50%" height="50%" border="1px">


## 6. デプロイされた Management インスタンスに接続

コピーしたキーの文字列をファイルに書き込む。
```
% vi ~/.ssh/citc.key
% chmod 600 ~/.ssh/citc.key
```

作成したキーでインスタンスに SSH する。
```
% ssh -i ~/.ssh/citc.key opc@<IP Address>
```

Management インスタンスの初期設定を行う。
opc のホームディレクトリにある limits.yaml ファイルを編集します。

```
[opc@mgmt ~]$ vi limits.yaml
```

例えば VM.Standard2.1 を AD 1 に 1インスタンスのみデプロイできるようにするには以下のように変更します。
before:
```
#VM.Standard2.1:
#  1: 1
#  2: 1
#  3: 1
```

after:
```
VM.Standard2.1:
  1: 1
#  2: 1
#  3: 1
```

limits.yaml ファイルの編集が完了したら、finish コマンドを実行し、設定を反映させます。これにより slurm.conf が書き換わります。
```
[opc@mgmt ~]$ finish
```

# 参考 URL
https://cluster-in-the-cloud.readthedocs.io
