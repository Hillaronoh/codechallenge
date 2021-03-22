<template>
    <div class="row">
        <div class="col-md-12 col-sm-12 col-xs-12">
            <div class="x_panel">
                <div class="x_content">

                    <DxDataGrid
                        :ref="supplierProductsGrid"
                        :data-source="dataSource"
                        :remote-operations="true"
                        :allow-column-reordering="true"
                        :row-alternation-enabled="true"
                        :show-borders="true"
                        @toolbar-preparing="onToolbarPreparing($event)"
                        @cellDblClick="onEditSupplierProducts"
                    >
                        <DxColumn
                            data-field="order_number"
                            data-type="string"
                            caption="Order Number"
                            alignment="left"
                        />
                        <DxColumn
                            data-field="product_name"
                            data-type="string"
                            caption="Product"
                            alignment="left"
                        />
                        <DxColumn
                            data-field="created_at"
                            data-type="date"
                            caption="Date Added"
                        />

                        <DxPaging :page-size="500"/>
                        <DxPager
                            :show-page-size-selector="true"
                            :allowed-page-sizes="[500, 1000, 1500]"
                            :show-info="true"
                            :visible="true"
                            :infoText="`Page {0} of {1} ({2} items)`"
                        />

                        <DxGroupPanel :visible="true"/>
                        <DxSearchPanel
                            :width="250"
                            :visible="true"
                            :highlight-case-sensitive="true"
                        />
                        <DxGrouping :auto-expand-all="false"/>
                        <DxHeaderFilter :visible="true"/>

                    </DxDataGrid>

                </div>
            </div>
        </div>
        <DxPopup
            :visible.sync="popupVisible"
            :drag-enabled="false"
            :close-on-outside-click="false"
            :show-title="true"
            :width="`40%`"
            :height="`45%`"
            title="Order Information"
        >
            <DxScrollView
                width="100%"
                height="100%"
            >
                <orders-form
                    @popupVisibility="popupVisibility($event)"
                    :form-data="formData"
                    :is-update="isUpdate"
                    :order-number="orderNumber"
                >
                </orders-form>
            </DxScrollView>
        </DxPopup>
    </div>

</template>

<script>
    import {
        DxDataGrid,
        DxColumn,
        DxGrouping,
        DxGroupPanel,
        DxPager,
        DxPaging,
        DxSearchPanel,
        DxHeaderFilter
    } from 'devextreme-vue/data-grid';
    import {DxPopup} from 'devextreme-vue/popup';
    import {DxScrollView} from 'devextreme-vue/scroll-view';
    import OrdersForm from './../forms/OrdersForm'
    import {OrdersDataSource, SuppliersDataSource} from '../../../datasources/datasource';
    import notify from "devextreme/ui/notify";

    export default {
        name: "OrdersGrid",
        components: {
            DxDataGrid,
            DxColumn,
            DxGrouping,
            DxGroupPanel,
            DxPager,
            DxPaging,
            DxSearchPanel,
            DxHeaderFilter,
            DxPopup,
            DxScrollView,
            OrdersForm
        },
        data() {
            return {
                dataSource: OrdersDataSource,
                supplierProductsGrid: 'dataGrid',
                popupVisible: false,
                formData: {order_number: 1233},
                isUpdate: false,
                orderNumber: ''
            };
        },
        methods: {
            onToolbarPreparing(e) {
                e.toolbarOptions.items.unshift(
                    {
                        location: 'before',
                        widget: 'dxButton',
                        options: {
                            icon: 'add',
                            text: 'Add New',
                            onClick: this.showOrdersForm.bind(this)
                        }
                    }, {
                        location: 'after',
                        widget: 'dxButton',
                        options: {
                            icon: 'refresh',
                            onClick: this.refreshDataGrid.bind(this)
                        }
                    });
            },
            popupVisibility(visibility) {
                this.popupVisible = visibility;
            },
            refreshDataGrid() {
                this.$refs[this.supplierProductsGrid].instance.refresh();
            },
            showOrdersForm() {
                var me = this;
                me.formData = {};
                me.isUpdate = false;
                axios({url: `api/v1/prepareOrder/`, method: 'GET'})
                    .then(response => {
                        let resp = response.data,
                            success = resp.success,
                            order_id = resp.order_id,
                            order_number = resp.order_number,
                            message = resp.message;
                        if (success) {
                            me.popupVisible = true;
                            me.orderNumber = order_number;
                            me.formData = {order_number: order_number, order_id: order_id};
                        } else {
                            notify({
                                message: message,
                                position: {
                                    my: 'center top',
                                    at: 'center top'
                                }
                            }, 'error', 3000);
                        }
                    })
                    .catch(err => {
                        notify({
                            message: err,
                            position: {
                                my: 'center top',
                                at: 'center top'
                            }
                        }, 'error', 3000);
                    })
            },
            onEditSupplierProducts(e) {
                this.popupVisible = true;
                this.isUpdate = true;
                this.formData = e.data;
            }
        }
    }
</script>

<style scoped>

</style>
