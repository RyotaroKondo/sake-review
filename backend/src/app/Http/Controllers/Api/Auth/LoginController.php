<?php

namespace App\Http\Controllers\Api\Auth;

use App\Http\Controllers\Controller;
use Illuminate\Foundation\Auth\AuthenticatesUsers;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class LoginController extends Controller
{
    use AuthenticatesUsers;

    /**
     * ログイン
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response|\Illuminate\Http\JsonResponse
     *
     * @throws \Illuminate\Validation\ValidationException
     */
    public function login(Request $request)
    {
        // バリデーション
        $this->validateLogin($request);
        $result = false;
        $status = 401;
        $message = 'ユーザが見つかりません';
        $user = null;
        $credentials = $request->only('email', 'password');
        if (Auth::attempt($credentials)) {
            // Success
            $result = true;
            $status = 200;
            $message = 'OK';
            $user = Auth::user();
            // ※古いトークン削除&新しいトークン生成
            $user->tokens()->where('name', 'token-name')->delete();
            $token = $user->createToken('token-name')->plainTextToken;
        }
        return response()->json(['result' => $result, 'status' => $status, 'user' => $user, 'message' => $message]);
    }


    /**
     * ログアウト
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response|\Illuminate\Http\JsonResponse
     */
    public function logout(Request $request)
    {
        Auth::logout();
        $result = true;
        $status = 200;
        $message = 'ログアウトしました';
        return response()->json(['result' => $result, 'status' => $status, 'message' => $message]);
    }
}