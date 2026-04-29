<?php

namespace App\Models;

class UserModel extends Model{
    protected $table = 'utilisateur';
    protected $primaryKey = 'id';
    protected $allowedFields = ['nom', 'prenom', 'password'];


    public function ifUserExist($nom, $prenom, $password){
        $u = $this->where(['nom' => $nom, 'prenom' => $prenom])->first();
        if($u == null){
            return false;
        }
        return password_verify($password, $u['password']);
    }
}