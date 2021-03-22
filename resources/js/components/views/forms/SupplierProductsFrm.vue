<template>
    <div>
        <form @submit="handleSubmit">
            <DxForm
                :read-only="false"
                :show-colon-after-label="true"
                :show-validation-summary="true"
                :label-location="labelLocation"
                :col-count="1"
                :ref="suppliersForm"
                :form-data="formData"
                :is-update="isUpdate"
            >
                <DxSimpleItem data-field="id" :visible="false"/>
                <DxGroupItem :col-count="1">
                    <DxSimpleItem
                        data-field="supplier_id"
                        editor-type="dxSelectBox"
                        :editor-options="supplierOptions"
                        :visible="true"
                        :isRequired="true"
                    >
                        <DxLabel text="Supplier"/>
                    </DxSimpleItem>
                </DxGroupItem>
                <DxGroupItem :col-count="1">
                    <DxSimpleItem
                        data-field="product_id"
                        editor-type="dxSelectBox"
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
    import {SuppliersDataSource, ProductsDataSource, SupplierProductsDataSource} from '../../../datasources/datasource'

    export default {
        name: "SupplierProductsFrm",
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
        props: ['formData', 'isUpdate'],
        data() {
            return {
                labelLocation: 'top',
                suppliersForm: 'dxForm',
                supplierOptions: {
                    dataSource: SuppliersDataSource,
                    displayExpr: 'name',
                    valueExpr: 'id',
                    searchEnabled: true,
                    showClearButton: true
                },
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
                this.saveSupplierProducts(e);
            },
            saveSupplierProducts(e) {
                e.preventDefault();
                const form = this.$refs[this.suppliersForm].instance;
                if (form.validate().isValid) {
                    axios({url: 'api/v1/saveSupplierProductDetails', data: form.option("formData"), method: 'POST'})
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
                                SupplierProductsDataSource.reload();
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

            deleteSupplierProduct() {
                let result = confirm("Are you sure to delete this record?", "Confirm Action");
                result.then((dialogResult) => {
                    if (dialogResult) {
                        const form = this.$refs[this.suppliersForm].instance,
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
