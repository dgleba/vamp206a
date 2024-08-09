#!/usr/bin/env bash
cd
# echo off
set +vx
# echo on
set -vx
source shc/21env.sh

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# yii2
# based on doing it easy basic yii2 template /  app - see lesson 5

#ciy207

sudo composer global require "fxp/composer-asset-plugin"

cd /var/www/html

composer create-project --prefer-dist yiisoft/yii2-app-basic ciy207

get a blank one to compare to... 
2015-12-07
composer create-project --prefer-dist yiisoft/yii2-app-basic ciy207b

gii
http://www.yiiframework.com/doc-2.0/guide-start-gii.html

http://hostname/index.php?r=gii

http://vamp206b/ciy207/web/index.php?r=gii


#in: config/web.php  line~55
# set allowed ip for gii
    $config['modules']['gii'] = [
        'class' => 'yii\gii\Module',
        // David Gleba 2015-11-28_Sat_18.58-PM
        'allowedIPs' => ['127.0.0.1', '::1', '192.168.88.*', '10.4.10.251'] // adjust this to your needs

set creds in \\VAMP206B\html\ciy207\config\db.php

_____________


generate model tbl cilisting1  model Cilisting1

_____________


Generating code using template "/var/www/html/ciy207/vendor/yiisoft/yii2-gii/generators/model/default"...
generating models/Cilisting1.php
Unable to write the file '/var/www/html/ciy207/models/Cilisting1.php'.

sudo chmod 777 -R /var/www/html/ciy207/models
sudo chmod 777 -R /var/www/html/ciy207/views
sudo chmod 777 -R /var/www/html/ciy207/controllers

_____________


crud gen

app\models\Cilisting1
app\models\Cilisting1Search
app\controllers\Cilisting1Controller
view path not set.

_____________

http://vamp206b/ciy207/web/index.php?r=cilisting1/index

Unknown Property � yii\base\UnknownPropertyException
Getting unknown property: app\models\Cilisting1Search::z
	'z-updatedtime' => $this->z-updatedtime,
3. in /var/www/html/ciy207/models/Cilisting1Search.php at line 74 � yii\db\BaseActiveRecord::__get('z')

cant have dashes in the field name?

commented out and removed    z-updatedtime

works..

_____________

move edit buttons to left side of grid...


\\VAMP206B\html\ciy207\views\cilisting1\index.php
move to first column...
            ['class' => 'yii\grid\ActionColumn'],
 
        'columns' => [
            ['class' => 'yii\grid\ActionColumn'],
            ['class' => 'yii\grid\SerialColumn'],

it was near the bottom.	

==

        'columns' => [
        [
	'class' => 'yii\grid\ActionColumn',
	//'header'=>'Actn', 
	//'headerOptions' => ['width' => '30'],
	'template' => '{view} {link}',
        ],
            ['class' => 'yii\grid\SerialColumn'],
            //'ft',
             'ciid',
 
_____________

http://vamp206b/ciy207/web/index.php?r=cilisting1%2Findex
_____________

change columns and order..

\\VAMP206B\html\ciy207\views\cilisting1\index.php

_____________

column width..

http://www.bsourcecode.com/yiiframework2/gridview-in-yiiframework-2-0/#gridview-options

noworky..

used the following workaround.  underscores in the label..

            [
            'attribute' => 'comments',
             'label'=>'Comments____________________________',
             'format' => ['ntext'],
             //'format' =>  ['date', 'php:Y-m-d H:i:s'],
             //'options' => ['width' => '1200em'],
             'contentOptions'=>['style'=>'max-width: 900px;'],
             'contentOptions'=>['style'=>'width: 800px;']
                //'options'=>array('width'=>'40px'),
            ],

_____________
label
works..

            //'actual_implementation_date',
            [
            'attribute' => 'actual_implementation_date',
             'label'=>'Act Impl Date',
            ],

_____________


cool grid demo...

http://demos.krajee.com/grid-demo?_tog7ce9367e=page

_____________


# backup ciy207 ...
cd /var/www/html/ciy207
tar -cvzf ciy207.$(date +"%Y.%m.%d_%k.%M.%S").tgz  /var/www/html/ciy207 --exclude={tmp,backup,Trash/files,backup/*.tgz,*.tgz} 






=