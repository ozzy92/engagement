import generate_cost_center from "./department_cost_center";

// this is set when showing the employee selector, used by selectEmployee later
var employee_selector_field;

function showEmployeeSearch(employee_field, title) {
    console.log('Showing employee search for ' + employee_field);
    employee_selector_field = employee_field;
    $('#employeeSelectorModal').modal();
    $('#employeeSelectorModalLabel').text(title);
}

function selectEmployee(employee_id) {
    console.log('Employee ' + employee_id + ' selected for ' + employee_selector_field);

    const selector_field = employee_selector_field;

    $('#' + selector_field + '_id').val(employee_id);

    $.ajax({ url: '/employees/' + employee_id + '.json' })
        .done((data) => {
            console.log('Got employee ' + employee_id + ' data!');
            console.log(data);
            $('#' + selector_field + '_first_name').val(data.first_name);
            $('#' + selector_field + '_last_name').val(data.last_name);
            $('#' + selector_field + '_email').val(data.email);
        });
}

function clearEmployee(employee_field) {
    console.log('Clearing ' + employee_field);

    $('#' + employee_field + '_id').val('');
    $('#' + employee_field + '_first_name').val('');
    $('#' + employee_field + '_last_name').val('');
    $('#' + employee_field + '_email').val('');
}

export { showEmployeeSearch, selectEmployee, clearEmployee };
