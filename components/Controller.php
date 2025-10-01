<?php

namespace mdm\admin\components;

use mdm\admin\models\Assignment;
use yii\web\Controller as BaseController;
use yii\web\NotFoundHttpException;

/**
 * Controller base class
 */
class Controller extends BaseController
{
    public $userClassName;
    public $idField = 'id';
    public $usernameField = 'username';
    public $fullnameField;
    public $searchClass;
    public $extraColumns = [];

    protected function findUserModel($id){
        $class = $this->userClassName;
        $user = $class::findIdentity($id);
        if ($user !== null) {
            return $user;
        } else {
            throw new NotFoundHttpException('The requested page does not exist.');
        }
    }

    protected function findAssignmentModel($id){
        $user = $this->findUserModel($id);
        if ($user !== null) {
            return new Assignment($id, $user);
        } else {
            throw new NotFoundHttpException('The requested page does not exist.');
        }
    }

}
