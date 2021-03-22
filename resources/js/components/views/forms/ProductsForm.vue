<template>
    <div>
        <form @submit="handleSubmit">
            <DxForm
                :read-only="false"
                :show-colon-after-label="true"
                :show-validation-summary="true"
                :label-location="labelLocation"
                :col-count="1"
                :ref="productsForm"
                :form-data="formData"
                :is-update="isUpdate"
            >
                <DxSimpleItem data-field="id" :visible="false"/>
                <DxGroupItem :col-count="1">
                    <DxSimpleItem data-field="name">
                        <DxLabel text="Name"/>
                        <DxRequiredRule message="Name is required"/>
                    </DxSimpleItem>
                </DxGroupItem>
                <DxGroupItem :col-count="1">
                    <DxSimpleItem data-field="description">
                        <DxLabel text="Description"/>
                        <DxRequiredRule message="Description is required"/>
                    </DxSimpleItem>
                </DxGroupItem>
                <DxGroupItem :col-count="1">
                    <DxSimpleItem data-field="quantity">
                        <DxLabel text="Quantity"/>
                        <DxRequiredRule message="Quantity is required"/>
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
                        @click="deleteProduct"
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
    import {ProductsDataSource} from '../../../datasources/datasource'

    export default {
        name: "ProductsForm",
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
                productsForm: 'dxForm'
            };
        },
        computed: {},
        methods: {
            popupVisibility(visibility) {
                this.$emit('popupVisibility', visibility);
            },
            handleSubmit(e) {
                e.preventDefault();
                if (this.isUpdate == true) {
                    this.updateProduct(e);
                } else {
                    this.createProduct(e);
                }
            },
            createProduct(e) {
                e.preventDefault();
                const form = this.$refs[this.productsForm].instance;
                if (form.validate().isValid) {
                    axios({url: 'api/v1/product', data: form.option("formData"), method: 'POST'})
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
                                ProductsDataSource.reload();
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
            updateProduct(e) {
                e.preventDefault();
                const form = this.$refs[this.productsForm].instance,
                    id = form.option("formData").id;
                if (form.validate().isValid) {
                    axios({url: `api/v1/product/${id}`, data: form.option("formData"), method: 'PUT'})
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
                                ProductsDataSource.reload();
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
            deleteProduct() {
                let result = confirm("Are you sure to delete this product?", "Confirm Action");
                result.then((dialogResult) => {
                    if (dialogResult) {
                        const form = this.$refs[this.productsForm].instance,
                            data = form.option("formData"),
                            id = data.id;
                        axios({url: `api/v1/product/${id}`, method: 'DELETE'})
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
                                    ProductsDataSource.reload();
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

