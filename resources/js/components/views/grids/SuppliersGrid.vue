<template>
    <div class="row">
        <div class="col-md-12 col-sm-12 col-xs-12">
            <div class="x_panel">
                <div class="x_content">

                    <DxDataGrid
                        :ref="suppliersGrid"
                        :data-source="dataSource"
                        :remote-operations="true"
                        :allow-column-reordering="true"
                        :row-alternation-enabled="true"
                        :show-borders="true"
                        @toolbar-preparing="onToolbarPreparing($event)"
                        @cellDblClick="onEditSupplier"
                    >
                        <DxColumn
                            data-field="name"
                            data-type="string"
                            caption="Name"
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
            :height="`35%`"
            title="Supplier Information"
        >
            <DxScrollView
                width="100%"
                height="100%"
            >
                <suppliers-form
                    @popupVisibility="popupVisibility($event)"
                    :form-data="formData"
                    :is-update="isUpdate"
                >
                </suppliers-form>
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
    import SuppliersForm from './../forms/SuppliersForm'
    import {SuppliersDataSource} from '../../../datasources/datasource';

    export default {
        name: "SuppliersGrid",
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
            SuppliersForm
        },
        data() {
            return {
                dataSource: SuppliersDataSource,
                suppliersGrid: 'dataGrid',
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
                this.$refs[this.suppliersGrid].instance.refresh();
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
