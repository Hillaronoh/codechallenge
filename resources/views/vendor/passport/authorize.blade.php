<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">

    <title>{{ config('app.name') }} - Authorization</title>

    <!-- Styles -->
    <link href="{{asset('public/css/bootstrap.min.css')}}" rel="stylesheet">
    <link rel="stylesheet" href="{{ asset('public/css/app.css') }}">
    <link href="{{asset('public/fonts/css/font-awesome.min.css')}}" rel="stylesheet">

    <style>
        .passport-authorize .container {
            margin-top: 30px;
        }

        .passport-authorize .scopes {
            margin-top: 20px;
        }

        .passport-authorize .buttons {
            margin-top: 25px;
            text-align: center;
        }

        .passport-authorize .btn {
            width: 125px;
        }

        .passport-authorize .btn-approve {
            margin-right: 15px;
        }

        .passport-authorize form {
            display: inline;
        }
    </style>
</head>
<body class="passport-authorize">
<div class="container">
    <div class="row justify-content-center">
        <div class="col-md-2"></div>
        <div class="col-md-8">

            <div class="panel panel-info">
                <div class="panel-heading">
                    Authorization Request
                </div>
                <div class="panel-body">
                    <!-- Introduction -->
                    <p style="text-align: center">
                        <strong>{{ $client->name }}</strong> is requesting permission to access your account.
                    </p>

                    <!-- Scope List -->
                    @if (count($scopes) > 0)
                        <div class="scopes">
                            <p><strong>This application will be able to:</strong></p>

                            <ul>
                                @foreach ($scopes as $scope)
                                    <li>{{ $scope->description }}</li>
                                @endforeach
                            </ul>
                        </div>
                    @endif

                    <div class="buttons">
                        <!-- Authorize Button -->
                        <form method="post" action="{{ route('passport.authorizations.approve') }}">
                            @csrf

                            <input type="hidden" name="state" value="{{ $request->state }}">
                            <input type="hidden" name="client_id" value="{{ $client->id }}">
                            <input type="hidden" name="auth_token" value="{{ $authToken }}">
                            <button type="submit" class="btn btn-success btn-approve"><i
                                        class="fa fa-thumbs-up"></i> Authorize
                            </button>
                        </form>

                        <!-- Cancel Button -->
                        <form method="post" action="{{ route('passport.authorizations.deny') }}">
                            @csrf
                            @method('DELETE')

                            <input type="hidden" name="state" value="{{ $request->state }}">
                            <input type="hidden" name="client_id" value="{{ $client->id }}">
                            <input type="hidden" name="auth_token" value="{{ $authToken }}">
                            <button class="btn btn-danger"><i class="fa fa-thumbs-down"></i> Deny</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-2"></div>
    </div>
</div>
</body>
</html>
