<template>
    <div id="page_content_view">
        <div class="container body">

            <div class="main_container">
                <top-nav></top-nav>
                <side-nav></side-nav>
                <!-- page content -->
                <div class="right_col" role="main" style="min-height: 740px">
                    <router-view></router-view>
                    <div class="clearfix"></div>
                </div>
                <!-- /page content -->
            </div>

            <div id="custom_notifications" class="custom-notifications dsp_none">
                <ul class="list-unstyled notifications clearfix" data-tabbed_notifications="notif-group">
                </ul>
                <div class="clearfix"></div>
                <div id="notif-group" class="tabbed_notifications"></div>
            </div>

        </div>

    </div>
</template>

<script>
    import TopNav from './layouts/TopNavComponent'
    import SideNav from './layouts/SideNavComponent'

    export default {
        name: "Dash",
        components: {
            TopNav,
            SideNav
        }
    }
</script>

<style scoped>

</style>
