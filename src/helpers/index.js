const helpers = {
    json: content => JSON.stringify(content),
    len: (arrStr) => arrStr.length,
    sum: (a, b) => a + b,
    notify: (message, type) => (message && type) ? `
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.1/jquery.min.js"></script>
    <script src="//cdnjs.cloudflare.com/ajax/libs/toastr.js/latest/toastr.min.js"></script>
    <script type="text/javascript">
        toastr.options.closeButton = true;
        toastr.options.timeOut = 10000;
        switch ("${type}") {
            case 'success': {
                toastr.success("${message}");
                break;
            }
            case 'error': {
                toastr.error("${message}");
                break;
            }
            case 'warning': {
                toastr.warning("${message}");
                break;
            }
            default:
                toastr.info("${message}");
        }
    </script>
    `: '',
    active: (checked) => checked ? 'text-danger' : 'text-dark',
}

module.exports = helpers;