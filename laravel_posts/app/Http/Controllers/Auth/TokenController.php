<?php
namespace App\Http\Controllers\Auth;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Auth\AuthenticationException;
use Illuminate\Support\Facades\Auth;

class TokenController extends Controller
{
    public function store(Request $request)
    {
        $this->validate($request, [
            'email' => 'required|email',
            'password' => 'required',
        ]);

        if (!Auth::attempt($request->only('email', 'password'))) {
            throw new AuthenticationException('Unauthorized', $guards, route('login'));
        }
        return [
            'token' => auth()->user()->createToken($request->deviceId)->plainTextToken
        ];

    }

    public function destroy(Request $request){
        auth()->user()->tokens()->where('name',$request->deviceId)->delete();
    }

}
