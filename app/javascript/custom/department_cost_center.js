
// Helper function to do cost center generation ajax
// Is this the right way to do this?  Don't know, but gonna try it!
function generate_cost_center() {
    console.log('Running generate');
    $.ajax({ url: '/cost_centers/new' })
        .done((data) => {
            console.log('Got generate data! ' + data);
            $('#cost_center').val(data);
    });
}

export default generate_cost_center;
