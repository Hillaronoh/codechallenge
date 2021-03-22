<template>
    <div>
        <form @submit="handleSubmit">
            <DxForm
                :read-only="false"
                :show-colon-after-label="true"
                :show-validation-summary="true"
                :label-location="labelLocation"
                :col-count="1"
                :ref="ordersForm"
                :form-data="formData"
                :is-update="isUpdate"
                :order-number="orderNumber"
            >
                <DxSimpleItem data-field="id" :visible="false"/>
                <DxSimpleItem data-field="order_id" :visible="false"/>
                <DxGroupItem :col-count="1">
                    <DxSimpleItem
                        data-field="order_number"
                        :editor-options="orderOptions"
                    >
                        <DxLabel text="Order Number"/>
                        <DxRequiredRule message="Order Number is required"/>
                    </DxSimpleItem>
                </DxGroupItem>
                <DxGroupItem :col-count="1">
                    <DxSimpleItem
                        data-field="product_id"
                        editor-type="dxTagBox"
                        :editor-options="productOptions"
                        :visible="true"
                        :isRequired="true"
                    >
                        <DxLabel text="Product"/>
                    </DxSimpleItem>
                </DxGroupItem>
            </DxForm>
            <div class="row">
                <hr/>
            </div>
            <div class="row">
                <div class="col-sm-4 pull-right" style="text-align:right;">
                    <DxButton
                        text="Save Details"
                        type="success"
                        icon="save"
                        :useSubmitBehavior="true"
                    />
                </div>
                <div class="col-sm-4 pull-right" style="text-align:right;">
                    <DxButton
                        text="Delete"
                        type="danger"
                        icon="trash"
                        :visible="isUpdate"
                        @click="deleteSupplierProduct"
                    />
                </div>
            </div>
        </form>
    </div>
</template>

<script>
    import DxForm, {
        DxGroupItem,
        DxSimpleItem,
        DxButtonItem,
        DxLabel,
        DxRequiredRule,
        DxAsyncRule,
        DxButtonOptions,
    } from 'devextreme-vue/form';
    import {DxButton} from 'devextreme-vue';
    import notify from 'devextreme/ui/notify';
    import {confirm} from 'devextreme/ui/dialog';
    import {OrdersDataSource, ProductsDataSource, } from '../../../datasources/datasource'

    export default {
        name: "OrdersForm",
        components: {
            DxGroupItem,
            DxSimpleItem,
            DxButtonItem,
            DxLabel,
            DxRequiredRule,
            DxForm,
            DxAsyncRule,
            notify,
            DxButtonOptions,
            confirm,
            DxButton
        },
        props: ['formData', 'isUpdate', 'orderNumber'],
        data() {
            return {
                labelLocation: 'top',
                ordersForm: 'dxForm',
                orderOptions: {readOnly: true},
                productOptions: {
                    dataSource: ProductsDataSource,
                    displayExpr: 'name',
                    valueExpr: 'id',
                    searchEnabled: true,
                    showClearButton: true
                }
            };
        },
        computed: {},
        methods: {
            popupVisibility(visibility) {
                this.$emit('popupVisibility', visibility);
            },
            handleSubmit(e) {
                e.preventDefault();
                this.saveOrderDetails(e);
            },
            saveOrderDetails(e) {
                e.preventDefault();
                const form = this.$refs[this.ordersForm].instance;
                if (form.validate().isValid) {
                    axios({url: 'api/v1/saveOrderDetails', data: form.option("formData"), method: 'POST'})
                        .then(response => {
                            var resp = response.data,
                                success = resp.success,
                                message = resp.message;
                            if (success) {
                                notify({
                                    message: message,
                                    position: {
                                        my: 'center top',
                                        at: 'center top'
                                    }
                                }, 'success', 3000);
                                this.popupVisibility(false);
                                OrdersDataSource.reload();
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
                }
            },

            deleteOrderDetail() {
                let result = confirm("Are you sure to delete this record?", "Confirm Action");
                result.then((dialogResult) => {
                    if (dialogResult) {
                        const form = this.$refs[this.ordersForm].instance,
                            data = form.option("formData"),
                            id = data.id;
                        axios({url: `api/v1/deleteSupplierProductDetails/${id}`, method: 'DELETE'})
                            .then(response => {
                                let resp = response.data,
                                    success = resp.success,
                                    message = resp.message;
                                if (success) {
                                    notify({
                                        message: message,
                                        position: {
                                            my: 'center top',
                                            at: 'center top'
                                        }
                                    }, 'success', 3000);
                                    this.popupVisibility(false);
                                    SuppliersDataSource.reload();
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
                    }
                });
            }
        }
    }
</script>

<style scoped>
    form {
        margin: 10px;
    }
</style>
