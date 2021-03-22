<template>
    <!-- top navigation -->
    <div class="top_nav">

        <div class="nav_menu">
            <nav class="" role="navigation">
                <div class="nav toggle">
                    <a id="menu_toggle"><i class="fa fa-bars"></i></a>
                </div>

                <ul class="nav navbar-nav navbar-left">
                    <li class="">
                        <a href="javascript:;" class="user-profile dropdown-toggle" data-toggle="dropdown"
                           aria-expanded="false">
                            <h5>{{$route.meta.description.toUpperCase()}}</h5>
                        </a>
                    </li>
                </ul>

                <ul class="nav navbar-nav navbar-right">
                    <li class="">
                        <a href="javascript:;" class="user-profile dropdown-toggle" data-toggle="dropdown"
                           aria-expanded="false">
                            <img src="/app_two/public/images/img.jpg" alt="">{{user.name}}
                            <span class=" fa fa-angle-down"></span>
                        </a>
                        <ul class="dropdown-menu dropdown-usermenu animated fadeInDown pull-right">
                            <li><a href="javascript:;"> Profile</a>
                            </li>
                            <li>
                                <a href="javascript:;">
                                    <span class="badge bg-red pull-right">50%</span>
                                    <span>Settings</span>
                                </a>
                            </li>
                            <li>
                                <a href="javascript:;">Help</a>
                            </li>
                            <li>
                                <a @click="logout"><i class="fa fa-sign-out pull-right"></i> Log Out</a>
                            </li>
                        </ul>
                    </li>
                </ul>
            </nav>
        </div>

    </div>
    <!-- /top navigation -->
</template>

<script>
    export default {
        name: "TopNavComponent",
        data() {
            return {
                user: this.$store.state.user
            }
        },
        methods: {
            logout: function () {
                this.$store.dispatch('logout')
                    .then(() => {
                        this.$router.push('/login');
                        location.reload();
                    })
            }
        }
    }
</script>

<style scoped>

</style>
