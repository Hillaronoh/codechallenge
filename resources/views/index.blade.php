<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="x-ua-compatible" content="ie=edge">

    <title>API Portal</title>
    <meta name="csrf-token" content="{{ csrf_token() }}">
    <meta name="google-signin-client_id"
          content="938015073274-hscig9dhcuinpphn4kevie0lb3g63sji.apps.googleusercontent.com">
    <link rel="stylesheet" href="{{ asset('public/css/app.css') }}">
<!--<link href="{{asset('node_modules/devextreme/dist/css/dx.light.css')}}" rel="stylesheet">-->
    <link rel="icon" type="image/png" href="{{asset('public/images/favicon.ico')}}"/>
    <!--TEMPLATE-->
    <!-- Bootstrap core CSS -->

    <link href="{{asset('public/css/bootstrap.min.css')}}" rel="stylesheet">

    <link href="{{asset('public/fonts/css/font-awesome.min.css')}}" rel="stylesheet">
    <link href="{{asset('public/css/animate.min.css')}}" rel="stylesheet">
    <link rel="stylesheet" href="{{asset('node_modules/jqwidgets-scripts/jqwidgets/styles/jqx.base.css')}}"
          type="text/css"/>
    <link rel="stylesheet" href="{{asset('node_modules/jqwidgets-scripts/jqwidgets/styles/jqx.classic.css')}}"
          type="text/css"/>
    <!-- Custom styling plus plugins -->
    <link href="{{asset('public/css/all.css')}}" rel="stylesheet"><!--css/custom.css-->
    <link href="{{asset('public/css/icheck/flat/green.css')}}" rel="stylesheet">

    <link rel="stylesheet" type="text/css" href="{{asset('public/css/progressbar/bootstrap-progressbar-3.3.0.css')}}">
    <script src="{{asset('public/js/jquery.min.js')}}"></script>
{{--<script src="https://apis.google.com/js/platform.js" async defer></script>--}}

<!--END TEMPLATE-->
    <link rel="manifest" href="./manifest.json">
</head>

<body class="nav-md"><!--dx-viewport-->

<div id="app"></div>

<script src="{{ asset('public/js/bootstrap.min.js') }}"></script>

<!-- chart js -->
<script src="{{ asset('public/js/chartjs/chart.min.js') }}"></script>
<!-- bootstrap progress js -->
<script src="{{ asset('public/js/progressbar/bootstrap-progressbar.min.js') }}"></script>
<script src="{{ asset('public/js/nicescroll/jquery.nicescroll.min.js') }}"></script>
<!-- icheck -->
<script src="{{ asset('public/js/icheck/icheck.min.js') }}"></script>

<script src="{{ asset('public/js/custom/custom.js') }}"></script><!--js/custom.js-->
<!-- pace -->
<script src="{{ asset('public/js/pace/pace.min.js') }}"></script>
<!-- PNotify -->
<script type="text/javascript" src="{{asset('public/js/notify/pnotify.core.js')}}"></script>
<script type="text/javascript" src="{{asset('public/js/notify/pnotify.buttons.js')}}"></script>
<script type="text/javascript" src="{{asset('public/js/notify/pnotify.nonblock.js')}}"></script>

<script>
    var menus = '<?php echo $menus;?>',
        base_url = '<?php echo $base_url;?>';

    function onSignIn(googleUser) {
        var profile = googleUser.getBasicProfile();
        console.log('ID: ' + profile.getId()); // Do not send to your backend! Use an ID token instead.
        console.log('Name: ' + profile.getName());
        console.log('Image URL: ' + profile.getImageUrl());
        console.log('Email: ' + profile.getEmail()); // This is null if the 'email' scope is not present.
    }
</script>

<script type="application/javascript">
    $(function () {
        var cnt = 10; //$("#custom_notifications ul.notifications li").length + 1;
        TabbedNotification = function (options) {
            var message = "<div id='ntf" + cnt + "' class='text alert-" + options.type + "' style='display:none'><h2><i class='fa fa-bell'></i> " + options.title +
                "</h2><div class='close'><a href='javascript:;' class='notification_close'><i class='fa fa-close'></i></a></div><p>" + options.text + "</p></div>";

            if (document.getElementById('custom_notifications') == null) {
                alert('doesnt exists');
            } else {
                $('#custom_notifications ul.notifications').append("<li><a id='ntlink" + cnt + "' class='alert-" + options.type + "' href='#ntf" + cnt + "'><i class='fa fa-bell animated shake'></i></a></li>");
                $('#custom_notifications #notif-group').append(message);
                cnt++;
                CustomTabs(options);
            }
        };

        CustomTabs = function (options) {
            $('.tabbed_notifications > div').hide();
            $('.tabbed_notifications > div:first-of-type').show();
            $('#custom_notifications').removeClass('dsp_none');
            $('.notifications a').click(function (e) {
                e.preventDefault();
                var $this = $(this),
                    tabbed_notifications = '#' + $this.parents('.notifications').data('tabbed_notifications'),
                    others = $this.closest('li').siblings().children('a'),
                    target = $this.attr('href');
                others.removeClass('active');
                $this.addClass('active');
                $(tabbed_notifications).children('div').hide();
                $(target).show();
            });
        };

        CustomTabs();

        var tabid = idname = '';
        $(document).on('click', '.notification_close', function (e) {
            idname = $(this).parent().parent().attr("id");
            tabid = idname.substr(-2);
            $('#ntf' + tabid).remove();
            $('#ntlink' + tabid).parent().remove();
            $('.notifications a').first().addClass('active');
            $('#notif-group div').first().css('display', 'block');
        });
    })
</script>
<script type="text/javascript">
    var permanotice, tooltip, _alert;
    $(function () {
        new PNotify({
            title: "PNotify",
            type: "dark",
            text: "Welcome. Try hovering over me. You can click things behind me, because I'm non-blocking.",
            nonblock: {
                nonblock: true
            },
            before_close: function (PNotify) {
                // You can access the notice's options with this. It is read only.
                //PNotify.options.text;

                // You can change the notice's options after the timer like this:
                PNotify.update({
                    title: PNotify.options.title + " - Enjoy your Stay",
                    before_close: null
                });
                PNotify.queueRemove();
                return false;
            }
        });

    });
</script>
<script type="application/javascript">
    $(document).ready(function () {
        $('.progress .bar').progressbar(); // bootstrap 2
        $('.progress .progress-bar').progressbar(); // bootstrap 3
    });
</script>

<script src="{{ asset('public/js/app.js') }}"></script>
</body>
</html>
