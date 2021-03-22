<template>

    <div class="row">
        <div class="col-md-12 col-sm-12 col-xs-12">
            <div class="x_panel">
                <div class="x_content">
                    <!--<router-view></router-view>-->
                    <component :is="current_view" v-bind="dynamicProps" v-dynamic-events="knownEvents"></component>
                </div>
            </div>
        </div>
    </div>

</template>

<script>
    import ProductsGrid from './grids/ProductsGrid'
    import ProductsForm from './forms/ProductsForm'
    import {ProductsDataSource} from '../../datasources/datasource'
    export default {
        name: "Products",
        components:{
            ProductsGrid,
            ProductsForm
        },
        directives: {
            DynamicEvents: {
                bind: (el, binding, vnode) => {
                    const allEvents = binding.value;
                    Object.keys(allEvents).forEach((event) => {
                        // register handler in the dynamic component
                        vnode.componentInstance.$on(event, (eventData) => {
                            const targetEvent = allEvents[event];
                            vnode.context[targetEvent](eventData);
                        });
                    });
                },
                unbind: function (el, binding, vnode) {
                    vnode.componentInstance.$off();
                },
            },
        },
        data() {
            return {
                current_view: 'ProductsGrid',
                dynamicProps: {

                },
                knownEvents: {

                }
            };
        },
        created(){
            ProductsDataSource.reload();
        },
        methods:{

        }
    }
</script>

<style scoped>

</style>
