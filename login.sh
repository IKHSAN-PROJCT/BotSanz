#!/bin/bash

# Fungsi untuk menampilkan pesan login
tampilkan_login() {
    clear
    echo "==================================="
    echo "          LOGIN DIBUTUHKAN         "
    echo "==================================="
    echo ""
}
#!/bin/bash

# Deklarasi fungsi yang tidak akan ditampilkan
declare -f bukapw > /dev/null
declare -f verifikasi_kata_sandi > /dev/null

# Fungsi untuk mendekripsi kata sandi
bukapw() {
    private_key="private_key.pem"
    encrypted_password="encrypted_password.bin"
    password=$(openssl rsautl -decrypt -inkey $private_key -in $encrypted_password)
    echo "Password terenkripsi: $password"
}

# Fungsi untuk memeriksa kata sandi sebelum login
verifikasi_kata_sandi() {
    local input_password
    local percobaan=0

    while [ $percobaan -lt 3 ]; do
        read -s -p "Masukkan kata sandi: " input_password
        echo ""

        if [ "$input_password" == "$password" ]; then
            echo "Login berhasil!"
            touch ~/.login_berhasil
            return 0
        else
            ((percobaan++))
            if [ $percobaan -eq 3 ]; then
                echo "Kamu sudah melebihi batas percobaan."
                xdg-open "https://wa.me/683151697416"
                exit 2
            fi
            echo "Kata sandi salah! Silakan coba lagi. ($percobaan dari 3)"
        fi
    done
}

# Memeriksa apakah pengguna sudah login sebelumnya
if [ ! -f ~/.login_berhasil ]; then
    verifikasi_kata_sandi
fi

# Menjalankan skrip BotSanz.sh setelah berhasil login
bash BotSanz.sh


