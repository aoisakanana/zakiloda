# Read me  

# Whats this??  
おかざき向けうぷろだです。  
主要な機能は下記です。  

1. ユーザ機能  
1. D&Dで各種ファイルをアップロード  
1. リアルタイムに更新されるギャラリー  
1. アップロード済みファイルの一覧にアクセスし、管理する機能  
1. ゆるい操作権限  

# 環境構築  

# 環境設定(開発環境)  

* ntp(開発環境時計合わせ)  
    cat /etc/sysconfig/clock  
    sudo vi /etc/sysconfig/clock   
    UTC を Asia/Tokyoへ  
    sudo ln -sf /usr/share/zoneinfo/Asia/Tokyo /etc/localtime  
    sudo chkconfig ntpd on  
    sudo ntpdate ntp.nict.jp  
    sudo vi /etc/ntp.conf  
    sudo service ntpd restart   
    sudo chkconfig ntpd on  
    sudo hwclock --systohc  
 
* ruby 270  
    rvm get latest  
    rvm install "ruby-2.7.0"  
    rvm --default use 2.7.0  
    
* npm   
    npm install -g yarn  
    yarn  

* rails 602  
    gem list rails    
    gem i -v 6.0.2 rails  
    rails _6.0.2_ new appname  
    gem file 編集  
    gemfile.lock 削除  
    cd Projectフォルダ名  
    bundle install --without production  
    bundle update  
    rails g controller てきとうに  
    てきとうにMVVMそろえて、Routeを設定して。。  
    rails webpacker:install  

* sqlite3 >= 3.8へ      
    https://qiita.com/8zca/items/175efb0612070530d186  
        3.29をダウンロード  
        $ wget https://www.sqlite.org/2019/sqlite-autoconf-3290000.tar.gz  
        $ tar xzvf sqlite-autoconf-3290000.tar.gz  
        $ cd sqlite-autoconf-3290000  
        もとから入っているsqliteと競合しないように /opt/sqlite/sqlite3 にインストールします  
        $ ./configure --prefix=/opt/sqlite/sqlite3  
        $ make  
        $ sudo make install  
        バージョン確認  
        $ /opt/sqlite/sqlite3/bin/sqlite3 --version  
        3.29.0 2019-07-10 17:32:03 fc82b73eaac8b36950e527f12c4b5dc1e147e6f4ad2217ae43ad82882a88bfa6  
        $ gem uninstall sqlite3  
            上記でいれたlibとincludeのパスを指定してinstall  
         --with-sqlite3-includeが必要な旨を教えていただいたので追加  
            $ gem install sqlite3 -- --with-sqlite3-include=/opt/sqlite/sqlite3/include \  
               --with-sqlite3-lib=/opt/sqlite/sqlite3/lib  
            成功！  
  $ rake db:migrate  

* git remote連携  
git  
    ~/.ssh << ssh-keygen  
    ~/.ssh << config  
    Host 任意の接続名(hoge)  
    HostName ホスト名  
    User ユーザー名  
    Port ポート番号  
    IdentityFile 鍵へのPATH(例えば~/.ssh/hoge.key)  
    git config --global user.name "ユーザ名"  
    git config --global user.email "利用Eメールアドレス"  
    git init  
    git add .  
    git commit -m "first commit"  
    git remote add origin git@bitbucket.org:aoisakanana/pokebuilders_pp.git  
    git push origin master  
heroku  
    source <(curl -sL https://cdn.learnenough.com/heroku_install)  
    $tar zxf heroku-linux-x64.tar.gz  
    $ sudo mv heroku /usr/local/  
    (確認)
    $ ls /usr/local/heroku/  
    $echo 'PATH=/usr/local/heroku/bin:$PATH' >> $HOME/.bash_profile  
    $source $HOME/.bash_profile > /dev/null  
    heroku login --interactive   
    heroku keys:add ~/.ssh/heroku_id_rsa.pub   
    heroku create  

* user 基本機能 devise設定  
deviseインストール  
    yarn install --check-files  がかかるので、webpacker.ymlの設定を変更しておくのを推奨  
    rails g devise:install  
    deviseっぽいモデルを作ってくれる
    rails g devise User  
    deviseっぽいコントローラ、Viewをつくってくれる
    rails g devise:controllers Users  
    rails g devise:views Users  
    smtp,twitter連携のための設定はrails credentials:edit から記述
    rails credentials:edit
    Rails.application.credentials.gmail[:user_name] みたいにアクセスできるようになる。


* deviseセットアップについてもう少しここに追記予定



* ここで一度Herokuにデプロイして動作確認
本番環境でも動くことを確認する
    git checkout master
    git pull origin master
    コンフリクトを直して、マージ。
    git add 対象ファイル
    git commit -m "pull origin and fix conflict"
    git push heroku master
ここで、heroku側でのCredentialsを追記する必要がある。
Herokuの環境にはVimが入っていないし、入れても削除されるので、プラグインで入れるところから
    heroku plugins:install https://github.com/naaman/heroku-vim
    次に、Master.keyを環境変数に設定する必要がある
    heroku config:set RAILS_MASTER_KEY='cat config/master.key'
    Rails Credentials:editのために、EDITORを設定
    heroku config:set EDITOR="vim"
    heroku run rails credentials:edit