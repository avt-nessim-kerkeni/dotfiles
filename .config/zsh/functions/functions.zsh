function ls() {
    eza --icons --color=auto -F "$@"
}

function docker() {
    case $1 in
    ps)
        shift
        command dops "$@"
        ;;
    *)
        command docker "$@"
        ;;
    esac
}

function curl() {
    local add_jwt_token=1
    local url=""

    for arg in "$@"; do
        if [[ "$arg" =~ ^https?:// ]]; then
            url="$arg"
            break
        fi
    done

    if [[ -n "$url" ]] && [[ "$url" =~ ^https?://(localhost|127\.0\.0\.1)(:[0-9]+)?(/|$) ]] && [[ -n "$JWT_TOKEN" ]]; then
        for arg in "$@"; do
            if [[ "$arg" =~ ^(-H$|^--header)$ ]]; then
                shift
                local next_arg="$1"
                if [[ "$next_arg" =~ ^[Aa]uthorization: ]]; then
                    add_jwt_token=0
                    break
                fi
            fi
        done
    fi

    if ((add_jwt_token)); then
        command curl -H "Authorization: Bearer ${JWT_TOKEN}" "$@"
    else
        command curl "$@"
    fi
}
function get_api_token() {
    local email="nessim.kerkeni@groupe-avt.com"
    local password='~7"PuczD+=j:%wV'

    local payload=$(jq -n --arg e "$email" --arg p "$password" '{email: $e, password: $p}')

    local response=$(curl -s -k -X POST https://localhost/api/login_check \
        -H "Content-Type: application/json" \
        -d "$payload")

    local token=$(echo $response | jq -r '.token')

    if [[ "$token" == "null" || -z "$token" ]]; then
        echo "Failed to get token. Response was: $response"
        return 1
    fi

    export JWT_TOKEN="$token"
    echo "JWT_TOKEN set."
}
