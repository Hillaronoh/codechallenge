<?php

namespace App\Providers;

use App\Client;
use Illuminate\Foundation\Support\Providers\AuthServiceProvider as ServiceProvider;
use Illuminate\Support\Facades\Gate;
use Laravel\Passport\Passport;

class AuthServiceProvider extends ServiceProvider
{
    /**
     * The policy mappings for the application.
     *
     * @var array
     */
    protected $policies = [
        // 'App\Model' => 'App\Policies\ModelPolicy',
    ];

    /**
     * Register any authentication / authorization services.
     *
     * @return void
     */
    public function boot()
    {
        $this->registerPolicies();
        Passport::routes();
        Passport::enableImplicitGrant();
        Passport::useClientModel(Client::class);
        Passport::tokensCan([
            'create-supplier' => 'Create Supplier',
            'read-suppliers' => 'Read Suppliers',
            'update-supplier'=>'Update Suppliers',
            'delete-supplier' => 'Delete Suppliers'
        ]);
        //given in seconds
        Passport::tokensExpireIn(now()->addDays(3660));
        Passport::refreshTokensExpireIn(now()->addDays(30));
        //Passport::personalAccessTokensExpireIn(now()->addMonths(6));
    }
}
