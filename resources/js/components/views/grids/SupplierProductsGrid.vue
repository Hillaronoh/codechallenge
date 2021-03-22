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
                        @cellDblClick="onEditSupplier"
                    >
                        <DxColumn
                            data-field="supplier_name"
                            data-type="string"
                            caption="Supplier"
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
            title="Supplier Product Information"
        >
            <DxScrollView
                width="100%"
                height="100%"
            >
                <supplier-products-form
                    @popupVisibility="popupVisibility($event)"
                    :form-data="formData"
                    :is-update="isUpdate"
                >
                </supplier-products-form>
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
    import SupplierProductsForm from './../forms/SupplierProductsFrm'
    import {SupplierProductsDataSource} from '../../../datasources/datasource';

    export default {
        name: "SupplierProductssGrid",
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
            SupplierProductsForm
        },
        data() {
            return {
                dataSource: SupplierProductsDataSource,
                supplierProductsGrid: 'dataGrid',
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
                            onClick: this.showSuppliersForm.bind(this)
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
            showSuppliersForm() {
                this.popupVisible = true;
                this.formData={};
                this.isUpdate = false;
            },
            onEditSupplier(e) {
                this.popupVisible = true;
                this.isUpdate = true;
                this.formData = e.data;
            }
        }
    }
</script>

<style scoped>

</style>
