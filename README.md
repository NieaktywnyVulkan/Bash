# Monitor parametrów systemu (Bash)

## Opis projektu

Skrypt Bash monitoruje podstawowe parametry systemu:
- adres IP
- ilość pamięci RAM
- liczba procesorów

### Działanie:

- przy **pierwszym uruchomieniu** -> wysyła e-mail z aktualnym stanem
- przy **kolejnych uruchomieniach**:
  - jeśli parametry się zmieniły -> wysyła e-mail
  - jeśli nie → nie wykonuje żadnej akcji

Stan zapisywany jest w pliku `state.txt` w folderze skryptu.

---

## Wymagania

System Linux:
- Ubuntu lub Fedora (instrukcja przewiduje te dystrybucje)

Konto e-mail (zalecany Gmail)
Plik konfiguracyjny ~/.msmtprc

---

## Instalacja wymaganych narzędzi

### Ubuntu:
```bash
sudo apt update
sudo apt install mailutils msmtp msmtp-mta
```

### Fedora:
```bash
sudo dnf install mailx msmtp msmtp-mta
```

## Konfiguracja:

W pliku skryptu `v3.sh`, należy wpisać w 3 linijce swój gmail

Skrypt został przygotowany do współpracy z kontem Gmail (SMTP: smtp.gmail.com)
Możliwe jest użycie innych dostawców (np. Outlook), jednak wymaga to zmiany konfiguracji SMTP w pliku `.msmtprc`.

Plik .msmtprc.template należy skonfigurować w następujący sposób:
w miejscu YOUR_EMAIL@gmail.com wpisz swój adres e-mail
w miejscu TWOJE_HASLO_APLIKACJI wpisz hasło aplikacji

(WAŻNE!)
Nie używamy zwykłego hasła do Gmaila.
Należy wygenerować hasło aplikacji:

Konto Google -> Bezpieczeństwo
Włącz weryfikację dwuetapową
Wybierz „Hasła aplikacji” (często ukryte, należy wtedy w ustawieniach zarządzania kontem google wpisać "Hasła do aplikacji")
Wygeneruj hasło dla aplikacji „Mail”

(WAŻNE!)
Plik musi:

nazywać się .msmtprc
znajdować się w katalogu domowym użytkownika (~/.msmtprc)

Uprawnienia pliku konfiguracyjnego (chmod 600 ~/.msmtprc)
Uprawnienia skryptu (chmod +x script.sh)