<template>

    <div class="">
        <a class="hiddenanchor" id="toregister"></a>
        <a class="hiddenanchor" id="tologin"></a>

        <div id="wrapper">
            <div id="login" class="animate form">
                <section class="login_content">
                    <form @submit.prevent="login">
                        <h1>Login Form</h1>
                        <div>
                            <input type="text" v-model="email" class="form-control" placeholder="Username" required=""/>
                        </div>
                        <div>
                            <input type="password" v-model="password" class="form-control" placeholder="Password"
                                   required=""/>
                        </div>
                        <div class="row">
                            <div class="col-sm-6">
                                <button type="submit" class="btn btn-default submit"><i class="fa fa-sign-in"></i> Log
                                    in
                                </button>
                            </div>
                            <div class="col-sm-6">
                                <div class="g-signin2" data-onsuccess="onSignIn"></div>
                            </div>
                            <!--<a class="reset_pass" href="#">Lost your password?</a>-->
                        </div>
                        <div class="clearfix"></div>
                        <div class="separator">
                            <div class="clearfix"></div>
                            <br/>
                            <div>
                                <h1><i class="fa fa-sun-o" style="font-size: 26px;"></i> Solutech</h1>

                            </div>
                        </div>
                    </form>
                    <!-- form -->
                </section>
                <!-- content -->
            </div>
            <div id="register" class="animate form">
                <section class="login_content">
                    <form>
                        <h1>Create Account</h1>
                        <div>
                            <input type="text" class="form-control" placeholder="Username" required=""/>
                        </div>
                        <div>
                            <input type="email" class="form-control" placeholder="Email" required=""/>
                        </div>
                        <div>
                            <input type="password" class="form-control" placeholder="Password" required=""/>
                        </div>
                        <div>
                            <a class="btn btn-default submit" href="index.html">Submit</a>
                        </div>
                        <div class="clearfix"></div>
                        <div class="separator">

                            <p class="change_link">Already a member ?
                                <a href="#tologin" class="to_register"> Log in </a>
                            </p>
                            <div class="clearfix"></div>
                            <br/>
                            <div>
                                <h1><i class="fa fa-sun-o" style="font-size: 26px;"></i> API Portal</h1>

                                <p>©2020 All Rights Reserved. API Portal based on OAuth2.0. Privacy and
                                    Terms</p>
                            </div>
                        </div>
                    </form>
                    <!-- form -->
                </section>
                <!-- content -->
            </div>
        </div>
    </div>

</template>

<script>

    export default {
        name: "Login",
        data() {
            return {
                email: '',
                password: ''
            }
        },
        methods: {
            login: function () {
                let email = this.email;
                let password = this.password;
                this.$store.dispatch('login', {email, password})
                    .then(() => {
                        this.$router.push('/');
                        location.reload();
                    })
                    .catch(err => console.log(err))
            }

        }
    }
</script>

<style scoped>

</style>
