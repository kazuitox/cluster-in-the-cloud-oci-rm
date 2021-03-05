# 1. 概要
本リポジトリは Cluster in the Cloud (https://github.com/clusterinthecloud/terraform) を OCI の Resource Manager でデプロイできるようにしたものです。

# 2. Cluster in the Cloud とは
University of Bristol の Matt Williams さんが作成された Slurm を aws/gcp/oci でデプロイできる Terraform スクリプトです。
Slurm の Cloud Scheduling がセットアップされており、 Cloud 上に以下のオンデマンド環境が簡単にデプロイできます。

<img src="https://github.com/kazuitox/cluster-in-the-cloud-oci-rm/blob/main/images/diagram.png" width="50%" height="50%" align="center">

# 3. 使い方
## 3-1. 本リポジトリの zip ファイルをダウンロード
<img src="https://github.com/kazuitox/cluster-in-the-cloud-oci-rm/blob/main/images/Download_zip_file.png" width="50%" height="50%" align="center">

## 3-2. OCI にログインし、user_OCID をコピー
* 画面右上の人アイコンをクリックし、Profile からユーザ名をクリックする。
<img src="https://github.com/kazuitox/cluster-in-the-cloud-oci-rm/blob/main/images/OCI_Profile.png" width="45%" height="45%" border="1px">
* User OCID をコピーする。
<img src="https://github.com/kazuitox/cluster-in-the-cloud-oci-rm/blob/main/images/OCI_User_OCID.png" width="50%" height="50%" border="1px">

## 3-3. メニューから Resource Manager -> Stack を選択
<img src="https://github.com/kazuitox/cluster-in-the-cloud-oci-rm/blob/main/images/OCI_RM_Stack.png" width="50%" height="50%" border="1px">

## 3-4. デプロイするコンパートメントを選択
* リストからデプロイするコンパートメントを選ぶ
<img src="https://github.com/kazuitox/cluster-in-the-cloud-oci-rm/blob/main/images/OCI_Compartment.png" width="30%" height="30%" border="1px">

## 3-5. Stack の作成
* Create Stack を選択する
<img src="https://github.com/kazuitox/cluster-in-the-cloud-oci-rm/blob/main/images/OCI_RM_Create_Stack.png" width="50%" height="50%" border="1px">

* Stack Configuration で .zip file を選択し、"1." でダウンロードした zip ファイルをアップロードして Next をクリックする
<img src="https://github.com/kazuitox/cluster-in-the-cloud-oci-rm/blob/main/images/OCI_RM_Stack_Info.png" width="50%" height="50%" border="1px">

* Review 画面になるので Create をクリックする
<img src="https://github.com/kazuitox/cluster-in-the-cloud-oci-rm/blob/main/images/OCI_RM_Stack_Review.png" width="50%" height="50%">

* Terraform Actions から Apply を選択する
<img src="https://github.com/kazuitox/cluster-in-the-cloud-oci-rm/blob/main/images/OCI_RM_Apply.png" width="50%" height="50%">

* デプロイが開始されます
<img src="https://github.com/kazuitox/cluster-in-the-cloud-oci-rm/blob/main/images/OCI_RM_Apply_Inprogress.png" width="50%" height="50%">

* 15分ほどでデプロイが完了します
<img src="https://github.com/kazuitox/cluster-in-the-cloud-oci-rm/blob/main/images/OCI_RM_Job_Succeeded.png" width="50%" height="50%">

* Outpus で IP アドレスと SSH Key をコピーします
<img src="https://github.com/kazuitox/cluster-in-the-cloud-oci-rm/blob/main/images/OCI_RM_Job_outputs.png" width="50%" height="50%">


## 3-6. デプロイされた Management インスタンスに接続

コピーしたキーの文字列をファイルに書き込む。
```
% vi ~/.ssh/citc.key
% chmod 600 ~/.ssh/citc.key
```

作成したキーでインスタンスに SSH する。
```
% ssh -i ~/.ssh/citc.key opc@<IP Address>
```

## 3-7.Management インスタンスの初期設定を行う
opc のホームディレクトリにある limits.yaml ファイルを編集します。

```
[opc@mgmt ~]$ vi limits.yaml
```

例えば VM.Standard2.1(1Core,16GB Mem のインスタンス) を AD 1 に 1インスタンスのみデプロイできるようにするには以下のように変更します。
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

limits.yaml ファイルの編集が完了したら、finish コマンドを実行し、設定を反映させます。これにより slurm.conf が書き換わり初期設定は完了です。
```
[opc@mgmt ~]$ finish
```

## 3-8.ユーザの作成
ユーザに割り当てる ssh key を作成します。
```
[opc@mgmt ~]$ mkdir ssh-keys
[opc@mgmt ~]$ ssh-keygen -t rsa -b 2048 -N '' -f ssh-keys/user01
```

ユーザを作成します。
```
[opc@mgmt ~]$ sudo /usr/local/sbin/add_user_ldap user01 test user01 file:///home/opc/ssh-keys/user01.pub
adding new entry "cn=user01,ou=People,dc=citc,dc=acrc,dc=bristol,dc=ac,dc=uk"

[opc@mgmt ~]$ id -a user01
uid=10001(user01) gid=100(users) groups=100(users)

[opc@mgmt ~]$ sudo su - user01
[user01@mgmt ~]$ pwd
/mnt/shared/home/user01
```

## 3-9.ジョブを投入
nstask=1 のサンプルのジョブスクリプトを作成して実行。
```
[user01@mgmt ~]$ sbatch sample.sh
Submitted batch job 2
[user01@mgmt ~]$ sinfo
PARTITION AVAIL  TIMELIMIT  NODES  STATE NODELIST
compute*     up   infinite      1 alloc# vm-standard2-1-ad1-0001
[user01@mgmt ~]$ squeue
             JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
                 2   compute   sample   user01 CF       0:04      1 vm-standard2-1-ad1-0001
```


# 4. 削除について
Resouce Manager から Destroy を実行してください。
この時、mgmt ノードは起動している状態でないと正常に削除できないのでご注意ください。

# 5. 参考情報
## 5-1. VM.Standard.E3.Flex インスタンスの利用について
この [E3 Flex インスタンス](https://docs.oracle.com/ja-jp/iaas/Content/Compute/References/computeshapes.htm#flexible)は OCPU(Core) と メモリサイズを柔軟に設定することができます。
この環境ではデフォルトで以下を定義しています。
- 1 OCPU, 16GB Mem
- 2 OCPU, 32GB Mem
- 4 OCPU, 64GB Mem
- 8 OCPU, 128GB Mem
- 16 OCPU, 256GB Mem
- 32 OCPU, 512GB Mem
- 64 OCPU, 1024GB Mem

OCPU(Core) や Mem を柔軟に設定したい場合は、以下ファイルの内容を書き換えてください。
- /etc/citc/shapes.yaml
- /home/opc/limit.conf

命名規則としては VM.Standard.E3.OCPU.Mem です。仮に 1 OCPU で 8 GB Mem を追加したい場合は、 VM.Standard.E3.1.8 と設定してください。

# ６. 本家の URL
https://cluster-in-the-cloud.readthedocs.io
