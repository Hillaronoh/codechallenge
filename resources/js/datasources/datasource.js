import CustomStore from 'devextreme/data/custom_store';
import DataSource from 'devextreme/data/data_source';

function isNotEmpty(value) {
    return value !== undefined && value !== null && value !== '';
}

export const UsersStore = new CustomStore({
    loadMode: "processed",
    key: "id",
    load: function (loadOptions) {
        return axios({
            url: `api/v1/user`,
            method: 'GET'
        })
            .then(resp => {
                var success = resp.data.success,
                    message = resp.data.message;
                if ((success) || success == true) {
                    return {data: resp.data.results, totalCount: resp.data.totalCount};
                }
                return [];
            })
            .catch(err => {
                alert(err)
            })
    }
});

export const UsersDataSource = new DataSource({
    store: UsersStore
});

export const SuppliersStore = new CustomStore({
    loadMode: "processed",
    key: "id",
    load: function (loadOptions) {
        return axios({
            url: `api/v1/supplier`,
            method: 'GET'
        })
            .then(resp => {
                var success = resp.data.success,
                    message = resp.data.message;
                if ((success) || success == true) {
                    return {data: resp.data.results, totalCount: resp.data.totalCount};
                }
                return [];
            })
            .catch(err => {
                alert(err)
            })
    }
});

export const SuppliersDataSource = new DataSource({
    store: SuppliersStore
});

export const ProductsStore = new CustomStore({
    loadMode: "processed",
    key: "id",
    load: function (loadOptions) {
        return axios({
            url: `api/v1/product`,
            method: 'GET'
        })
            .then(resp => {
                var success = resp.data.success,
                    message = resp.data.message;
                if ((success) || success == true) {
                    return {data: resp.data.results, totalCount: resp.data.totalCount};
                }
                return [];
            })
            .catch(err => {
                alert(err)
            })
    }
});

export const ProductsDataSource = new DataSource({
    store: ProductsStore
});

export const OrdersStore = new CustomStore({
    loadMode: "processed",
    key: "id",
    load: function (loadOptions) {
        return axios({
            url: `api/v1/getOrderDetails`,
            method: 'GET'
        })
            .then(resp => {
                var success = resp.data.success,
                    message = resp.data.message;
                if ((success) || success == true) {
                    return {data: resp.data.results, totalCount: resp.data.totalCount};
                }
                return [];
            })
            .catch(err => {
                alert(err)
            })
    }
});

export const OrdersDataSource = new DataSource({
    store: OrdersStore
});

export const SupplierProductsStore = new CustomStore({
    loadMode: "processed",
    key: "id",
    load: function (loadOptions) {
        return axios({
            url: `api/v1/getSupplierProducts`,
            method: 'GET'
        })
            .then(resp => {
                var success = resp.data.success,
                    message = resp.data.message;
                if ((success) || success == true) {
                    return {data: resp.data.results, totalCount: resp.data.totalCount};
                }
                return [];
            })
            .catch(err => {
                alert(err)
            })
    }
});

export const SupplierProductsDataSource = new DataSource({
    store: SupplierProductsStore
});

export const MenusStore = new CustomStore({
    loadMode: "processed",
    key: "id",
    load: function (loadOptions) {
        return axios({url: `getMenus`, method: 'GET'})
            .then(resp => {
                var success = resp.data.success,
                    message = resp.data.message,
                    results = resp.data.results;
                if ((success) || success == true) {
                    return results;
                }
                alert(message);
                return [];
            })
            .catch(err => {
                alert(err)
            })
    }
});

export const menuLevelsDataSource = new DataSource({
    store: new CustomStore({
        loadMode: "processed",
        key: "id",
        //remoteOperations: true,
        load: function (loadOptions) {
            let params = '?';
            [
                'skip',
                'take',
                'requireTotalCount',
                'requireGroupCount',
                'sort',
                'filter',
                'totalSummary',
                'group',
                'groupSummary'
            ].forEach(function (i) {
                if (i in loadOptions && isNotEmpty(loadOptions[i])) {
                    params += `${i}=${JSON.stringify(loadOptions[i])}&`;
                }
            });
            params = params.slice(0, -1);
            var filterOptions = loadOptions.filter ? JSON.stringify(loadOptions.filter) : "";
            return axios.get(`getAdminModuleParamFromTable`, {
                params: {
                    filter: filterOptions,
                    table_name: 'menu_levels'
                }
            })
                .then(resp => {
                    var success = resp.data.success,
                        message = resp.data.message,
                        results = resp.data.results;
                    if ((success) || success == true) {
                        return results;
                    }
                    return [];
                })
                .catch(() => {
                    throw 'Data Loading Error';
                });
        },
        byKey: function (key) {
            return $.get('getAdminModuleParamFromTable/' + key.toString());
        }
    })
});

export const parentMenusDataSource = new DataSource({
    store: new CustomStore({
        loadMode: "processed",
        key: "id",
        //remoteOperations: true,
        load: function (loadOptions) {
            let params = '?';
            [
                'skip',
                'take',
                'requireTotalCount',
                'requireGroupCount',
                'sort',
                'filter',
                'totalSummary',
                'group',
                'groupSummary'
            ].forEach(function (i) {
                if (i in loadOptions && isNotEmpty(loadOptions[i])) {
                    params += `${i}=${JSON.stringify(loadOptions[i])}&`;
                }
            });
            params = params.slice(0, -1);
            var filterOptions = loadOptions.filter ? JSON.stringify(loadOptions.filter) : "";
            return axios.get(`getMenus`, {
                params: {
                    level: 1,
                    filter: filterOptions
                }
            })
                .then(resp => {
                    var success = resp.data.success,
                        message = resp.data.message,
                        results = resp.data.results;
                    if ((success) || success == true) {
                        return results;
                    }
                    return [];
                })
                .catch(() => {
                    throw 'Data Loading Error';
                });
        },
        byKey: function (key) {
            return $.get('getMenus/' + key.toString());
        }
    })
});

export const childMenusDataSource = new DataSource({
    store: new CustomStore({
        loadMode: "processed",
        key: "id",
        //remoteOperations: true,
        load: function (loadOptions) {
            let params = '?';
            [
                'skip',
                'take',
                'requireTotalCount',
                'requireGroupCount',
                'sort',
                'filter',
                'totalSummary',
                'group',
                'groupSummary'
            ].forEach(function (i) {
                if (i in loadOptions && isNotEmpty(loadOptions[i])) {
                    params += `${i}=${JSON.stringify(loadOptions[i])}&`;
                }
            });
            params = params.slice(0, -1);
            var filterOptions = loadOptions.filter ? JSON.stringify(loadOptions.filter) : "";
            return axios.get(`getMenus`, {
                params: {
                    level: 2,
                    filter: filterOptions
                }
            })
                .then(resp => {
                    var success = resp.data.success,
                        message = resp.data.message,
                        results = resp.data.results;
                    if ((success) || success == true) {
                        return results;
                    }
                    return [];
                })
                .catch(() => {
                    throw 'Data Loading Error';
                });
        },
        byKey: function (key) {
            return $.get('getMenus/' + key.toString());
        }
    })
});

export const ClientsStore = new CustomStore({
    loadMode: "processed",
    key: "id",
    totalCount: 'totalCount',
    load: function (loadOptions) {
        return axios({url: `oauth/clients`, method: 'GET'})
            .then(resp => {
                return {data: resp.data, totalCount: resp.data.length};
            })
            .catch(err => {
                alert(err)
            })
    }
});

export const ClientsDataSource = new DataSource({
    store: ClientsStore
});


