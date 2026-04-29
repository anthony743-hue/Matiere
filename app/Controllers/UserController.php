<?php

namespace App\Controllers;
use App\Models\UserModel;

class UserController extends BaseController{
    public function login(){
        $request = $this->request;
        $user = new UserModel();
        $data = $request->getPost();

        if($user->ifUserExist($data['nom'], $data['prenom'], $data['password'])){
            return view('welcome_message');
        }
        return view('login');
    }
}