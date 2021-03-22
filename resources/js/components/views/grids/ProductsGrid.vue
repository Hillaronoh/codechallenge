<template>
    <div class="row">
        <div class="col-md-12 col-sm-12 col-xs-12">
            <div class="x_panel">
                <div class="x_content">

                    <DxDataGrid
                        :ref="productsGrid"
                        :data-source="dataSource"
                        :remote-operations="true"
                        :allow-column-reordering="true"
                        :row-alternation-enabled="true"
                        :show-borders="true"
                        @toolbar-preparing="onToolbarPreparing($event)"
                        @cellDblClick="onEditProduct"
                    >
                        <DxColumn
                            data-field="name"
                            data-type="string"
                            caption="Name"
                            alignment="left"
                        />
                        <DxColumn
                            data-field="description"
                            data-type="string"
                            caption="Description"
                            alignment="left"
                        />
                        <DxColumn
                            data-field="quantity"
                            data-type="string"
                            caption="Quantity"
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
            :height="`55%`"
            title="Product Information"
        >
            <DxScrollView
                width="100%"
                height="100%"
            >
                <products-form
                    @popupVisibility="popupVisibility($event)"
                    :form-data="formData"
                    :is-update="isUpdate"
                >
                </products-form>
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
    import ProductsForm from './../forms/ProductsForm'
    import {ProductsDataSource} from '../../../datasources/datasource';

    export default {
        name: "ProductsGrid",
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
            ProductsForm
        },
        data() {
            return {
                dataSource: ProductsDataSource,
                productsGrid: 'dataGrid',
                popupVisible: false,
                formData: {},
                isUpdate: false
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
                            onClick: this.showProductsForm.bind(this)
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
                this.$refs[this.productsGrid].instance.refresh();
            },
            showProductsForm() {
                this.popupVisible = true;
                this.formData={};
                this.isUpdate = false;
            },
            onEditProduct(e) {
                this.popupVisible = true;
                this.isUpdate = true;
                this.formData = e.data;
            }
        }
    }
</script>

<style scoped>

</style>
