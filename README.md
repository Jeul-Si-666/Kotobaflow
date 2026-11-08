
# KotobaFlow --- Product Requirements Document

> \[!abstract\] Product summary **KotobaFlow** adalah aplikasi
> pembelajaran kosakata bahasa Jepang berbasis Flutter yang membantu
> pengguna mempelajari, mengingat, menguji, dan mengevaluasi penguasaan
> kosakata melalui latihan terstruktur dan adaptif.
>
> **Tagline:** 言葉を、自然に。 --- Learn Japanese naturally, one word
> at a time.

## 0. Document Control

  Field                    Detail
  ------------------------ ------------------------------------------------
  Product                  KotobaFlow
  Document                 Product Requirements Document (PRD)
  Version                  1.0
  Status                   Draft --- menunggu konfirmasi keputusan produk
  Created                  2026-11-08
  Product type             Educational application
  Initial target           JLPT N5 vocabulary
  Primary platform         Android
  Additional platforms     iOS, Windows, Web
  Framework                Flutter
  Design direction         Japanese Editorial Minimalism
  Theme                    Light + Dark
  Architecture principle   Offline-first

## 1. Product Overview

### 1.1 Background

Menghafal kosakata bahasa Jepang tidak cukup hanya dengan membaca dan
mengulang kata. Pelajar pemula sering mengalami beberapa masalah:

-   Melupakan kosakata yang sebelumnya sudah dipelajari.
-   Sulit membedakan kosakata yang sudah dikuasai dan yang belum.
-   Tidak memiliki sistem evaluasi kemampuan yang konsisten.
-   Latihan terasa monoton karena hanya menggunakan flashcard.
-   Tidak mengetahui kosakata mana yang harus diprioritaskan untuk
    diulang.
-   Bisa mengenali kata saat melihatnya, tetapi kesulitan mengingatnya
    ketika diminta menerjemahkan dari bahasa Indonesia ke bahasa Jepang.

KotobaFlow dirancang untuk mengatasi masalah tersebut melalui sistem
pembelajaran kosakata yang terstruktur, terukur, dan adaptif.

### 1.2 Product Vision

Menjadi aplikasi pembelajaran kosakata bahasa Jepang yang membantu
pengguna mencapai penguasaan kosakata secara bertahap melalui
*personalized learning*.

### 1.3 Product Goals

  -----------------------------------------------------------------------
  ID                      Goal                    Indikator keberhasilan
  ----------------------- ----------------------- -----------------------
  G-01                    Mempermudah belajar     Vocabulary library
                          kosakata                tersedia dan dapat
                                                  dicari

  G-02                    Meningkatkan daya ingat Sistem pengulangan
                                                  terjadwal berjalan

  G-03                    Mengukur pemahaman      Quiz dan accuracy
                                                  tracking tersedia

  G-04                    Mengidentifikasi        Mistake tracking
                          kelemahan               mencatat kesalahan

  G-05                    Mendukung rutinitas     Daily goal dan streak
                          belajar                 tersedia

  G-06                    Fleksibel digunakan     Aktivitas belajar utama
                                                  dapat berjalan offline
  -----------------------------------------------------------------------

### 1.4 Product Principles

1.  **Learning first** --- pengguna dapat memulai latihan dengan cepat.
2.  **Minimal cognitive load** --- informasi ditampilkan seperlunya.
3.  **Progress visibility** --- perkembangan belajar mudah dipahami.
4.  **Mistake awareness** --- kosakata yang sering salah mudah
    ditemukan.
5.  **Offline-first** --- aktivitas belajar utama tidak bergantung pada
    internet.
6.  **Consistency** --- seluruh halaman menggunakan design tokens dan
    komponen yang konsisten.

## 2. Target Users

### 2.1 Primary User

Pelajar bahasa Jepang tingkat pemula yang sedang mempelajari kosakata
JLPT N5.

Karakteristik: - Belajar secara mandiri. - Memerlukan latihan kosakata
secara rutin. - Sudah mengenal Hiragana dan Katakana atau sedang
mempelajarinya. - Mulai mempelajari Kanji dasar. - Membutuhkan furigana
dan arti dalam bahasa Indonesia.

### 2.2 User Persona

> \[!example\] Japanese Beginner **Needs** - Menghafal kosakata N5. -
> Memahami arti dan penggunaan kosakata. - Melihat perkembangan
> belajar. - Mengulang kata yang sering salah.
>
> **Pain points** - Mudah lupa. - Tidak konsisten belajar. - Kesulitan
> mengingat Kanji dan cara baca. - Tidak mengetahui tingkat penguasaan
> kosakata.

## 3. Product Scope

### 3.1 Priority Definition

  Priority   Makna
  ---------- --------------------------------------
  P0         Wajib tersedia untuk MVP
  P1         Pengembangan setelah MVP inti stabil
  P2         Pengembangan jangka panjang

### 3.2 Feature Scope

  Feature                      Priority Scope
  -------------------------- ---------- --------------------------------------------
  Vocabulary Library                 P0 Daftar, pencarian, filter, detail kosakata
  Flashcard                          P0 Latihan dua arah
  Quiz Engine                        P0 Soal, pemeriksaan jawaban, hasil
  Learning Progress                  P0 Statistik aktivitas belajar
  Mistake Tracking                   P0 Pencatatan jawaban salah
  Local Database                     P0 Penyimpanan offline
  Spaced Repetition System           P1 Penjadwalan pengulangan
  Audio Pronunciation                P1 Audio pelafalan
  Daily Streak                       P1 Konsistensi belajar
  Listening Practice                 P1 Latihan pemahaman audio
  Cloud Synchronization              P2 Sinkronisasi antarperangkat
  Account System                     P2 Autentikasi pengguna
  Leaderboard                        P2 Kompetisi antarpengguna
  AI Learning Assistant              P2 Asisten belajar

> \[!important\] MVP scope Fokus awal adalah seluruh fitur P0. Fitur P1
> dan P2 tidak boleh menghambat penyelesaian MVP.

## 4. Functional Requirements

### FR-01 --- Vocabulary Management

**Description:** Pengguna dapat melihat, mencari, memfilter, dan
mempelajari kosakata.

Setiap vocabulary entry memiliki field berikut:

  Field                Example               Required
  -------------------- --------------------- ----------
  ID                   `n5_0001`             Yes
  Kanji                食べる                No
  Hiragana             たべる                Yes
  Romaji               Taberu                No
  Meaning              Makan                 Yes
  Word type            Verb                  Yes
  Verb group           Group 2               No
  Example Japanese     ご飯を食べます。      No
  Example Indonesian   Saya makan nasi.      No
  Audio path           `audio/n5_0001.mp3`   No
  JLPT level           N5                    Yes

**Requirements** - Kosakata mendukung Hiragana, Katakana, dan Kanji. -
Furigana tersedia untuk kata yang menggunakan Kanji. - Kosakata dapat
dikelompokkan berdasarkan jenis kata. - Pengguna dapat mencari dengan
Kanji, Hiragana, Romaji, atau arti bahasa Indonesia. - Pengguna dapat
menandai kosakata sebagai favorit.

**Acceptance criteria** - \[ \] Daftar kosakata dapat ditampilkan. - \[
\] Pencarian menemukan kata berdasarkan field yang didukung. - \[ \]
Filter kategori bekerja. - \[ \] Detail kosakata menampilkan informasi
yang tersedia. - \[ \] Favorit dapat ditambahkan dan dihapus.

### FR-02 --- Flashcard System

**Description:** Pengguna dapat berlatih mengingat kosakata melalui
kartu dua arah.

**Mode A --- Japanese → Indonesian** - Aplikasi menampilkan kosakata
Jepang. - Pengguna mencoba mengingat artinya. - Pengguna membuka kartu
untuk melihat arti dan informasi tambahan.

**Mode B --- Indonesian → Japanese** - Aplikasi menampilkan arti bahasa
Indonesia. - Pengguna mencoba mengingat kosakata Jepang. - Jawaban dapat
diberikan melalui pilihan atau input teks sesuai mode latihan.

Setelah melihat jawaban, pengguna dapat memberi penilaian: - **Again**
--- belum ingat. - **Hard** --- masih sulit. - **Good** --- sudah
ingat. - **Easy** --- sangat mudah.

Penilaian tersebut menjadi input untuk SRS ketika fitur SRS diaktifkan.

**Acceptance criteria** - \[ \] Kartu dapat dibalik. - \[ \] Kedua arah
latihan tersedia. - \[ \] Penilaian jawaban dapat dipilih. - \[ \] Hasil
latihan tersimpan secara lokal.

### FR-03 --- Quiz Engine

**Description:** Pengguna dapat menguji pemahaman kosakata melalui
beberapa jenis soal.

  -----------------------------------------------------------------------
  Question type                       Description
  ----------------------------------- -----------------------------------
  Multiple Choice                     Memilih arti atau kosakata yang
                                      benar

  Reverse Translation                 Mengubah arti bahasa Indonesia
                                      menjadi bahasa Jepang

  Fill in the Blank                   Melengkapi kalimat

  Typing                              Mengetik Hiragana atau Katakana

  Listening                           Menjawab berdasarkan audio

  Kanji Recognition                   Mengenali Kanji dan bacaannya
  -----------------------------------------------------------------------

**Requirements** - Soal ditampilkan satu per satu. - Jawaban diperiksa
setelah dikirim. - Penjelasan jawaban ditampilkan setelah pemeriksaan. -
Sistem menyimpan riwayat jawaban. - Hasil akhir menampilkan akurasi dan
daftar kesalahan.

**Acceptance criteria** - \[ \] Soal ditampilkan satu per satu. - \[ \]
Jawaban dapat dikirim dan diperiksa. - \[ \] Feedback benar/salah
ditampilkan. - \[ \] Hasil sesi dapat dilihat. - \[ \] Riwayat jawaban
tersimpan.

### FR-04 --- Mistake Tracking

**Description:** Sistem mencatat kesalahan pengguna dan membantu
menemukan kosakata yang belum dikuasai.

Data yang disimpan: - Vocabulary ID. - Arah latihan. - Jumlah
percobaan. - Jumlah jawaban benar. - Jumlah jawaban salah. - Waktu
terakhir salah. - Akurasi. - Status penguasaan.

**Important business rule:** Penguasaan Japanese → Indonesian dan
Indonesian → Japanese dicatat secara terpisah. Pengguna mungkin mampu
mengenali kata ketika melihat bahasa Jepang, tetapi belum mampu
mengingat kata tersebut dari arti bahasa Indonesia.

**Acceptance criteria** - \[ \] Jawaban salah menambah wrong count. - \[
\] Jawaban benar menambah correct count. - \[ \] Statistik per arah
latihan terpisah. - \[ \] Daftar kosakata lemah dapat ditampilkan.

### FR-05 --- Spaced Repetition System (P1)

**Description:** Sistem menentukan kapan kosakata perlu dipelajari
kembali.

**Input** - Hasil jawaban. - Tingkat kesulitan. - Riwayat latihan. -
Waktu terakhir dipelajari.

**Output** - Next review date. - Review interval. - Learning status.

Status vocabulary:

  Status       Description
  ------------ --------------------------------
  New          Belum pernah dipelajari
  Learning     Sedang dipelajari
  Review       Perlu diulang
  Mature       Sudah cukup stabil
  Relearning   Kembali dipelajari karena lupa

Untuk versi awal, gunakan algoritma SRS sederhana. Setelah sistem
stabil, evaluasi implementasi FSRS.

**Acceptance criteria** - \[ \] Jawaban memengaruhi jadwal review. - \[
\] Kosakata yang jatuh tempo masuk daftar review. - \[ \] Jadwal review
tersimpan secara lokal. - \[ \] Jadwal tetap tersedia setelah aplikasi
ditutup.

### FR-06 --- Learning Analytics

Dashboard menampilkan: - Total kosakata tersedia. - Total kosakata yang
pernah dipelajari. - Kosakata yang dikuasai. - Kosakata yang perlu
diulang. - Daily accuracy. - Overall accuracy. - Learning streak. -
Riwayat aktivitas.

**Business rule:** Semua metrik harus dihitung dari aktivitas pengguna
yang tersimpan, bukan angka statis.

**Acceptance criteria** - \[ \] Statistik diperbarui setelah sesi
latihan. - \[ \] Jumlah benar dan salah sesuai riwayat. - \[ \] Progress
harian sesuai aktivitas. - \[ \] Kosakata yang perlu diulang dapat
dilihat.

## 5. User Flow

### 5.1 Main Learning Flow

``` mermaid
flowchart TD
    A([Open KotobaFlow]) --> B[Home Dashboard]
    B --> C{Choose Activity}
    C --> D[Vocabulary]
    C --> E[Flashcard]
    C --> F[Quiz]
    C --> G[Review]
    D --> H[Select Vocabulary]
    H --> I[View Word Detail]
    E --> J[Answer Flashcard]
    F --> K[Answer Quiz]
    G --> L[Review Due Words]
    J --> M[Save Result]
    K --> M
    L --> M
    M --> N[Update Learning Progress]
    N --> O[Update Mistake Tracking]
    O --> P[Schedule Next Review]
    P --> B
```

### 5.2 Example User Journey

1.  Pengguna membuka aplikasi.
2.  Dashboard menampilkan kosakata yang perlu diulang.
3.  Pengguna memilih Review.
4.  Aplikasi menampilkan kosakata satu per satu.
5.  Pengguna menjawab.
6.  Sistem memeriksa jawaban.
7.  Sistem menyimpan hasil latihan.
8.  SRS menghitung jadwal berikutnya ketika fitur telah tersedia.
9.  Dashboard diperbarui.

## 6. UX/UI Requirements

### 6.1 Design Direction

**Japanese Editorial Minimalism**

Karakteristik: - Warm ivory sebagai warna dasar. - Vermilion red sebagai
aksen. - Charcoal sebagai warna teks. - Whitespace yang cukup. -
Tipografi Jepang yang jelas. - Sudut komponen membulat secukupnya. -
Animasi halus dan tidak berlebihan.

### 6.2 Color Tokens

  Semantic token   Light       Dark
  ---------------- ----------- -----------
  Background       `#F5F1E8`   `#20211F`
  Surface          `#FFFCF6`   `#2B2C29`
  Primary          `#B74735`   `#E47A62`
  Text Primary     `#282720`   `#F5F1E8`
  Text Secondary   `#77756D`   `#AAA79E`
  Border           `#E8DFD0`   `#41413B`
  Success          `#71836B`   `#A2B594`
  Warning          `#C58B43`   `#D9AD69`
  Error            `#B74735`   `#E47A62`

> \[!note\] Implementation rule Komponen UI menggunakan semantic theme
> tokens. Hindari hardcoded color di dalam widget.

### 6.3 Typography

  Usage                  Font
  ---------------------- ---------------
  Main UI                Noto Sans
  Japanese text          Noto Sans JP
  Editorial heading      Noto Serif JP
  Numbers / statistics   Noto Sans

Hierarchy: - Display heading: 28 px, semibold. - Section title: 20 px,
semibold. - Card title: 16 px, medium. - Body: 14 px, regular. -
Caption: 11 px, medium.

### 6.4 Spacing

  Token      Size
  ------- -------
  XS         4 px
  SM         8 px
  MD        12 px
  LG        16 px
  XL        24 px
  2XL       32 px
  3XL       48 px

### 6.5 Radius

  Component           Radius
  ----------------- --------
  Small component       8 px
  Button               12 px
  Card                 16 px
  Feature card         24 px
  Bottom sheet         24 px

### 6.6 Main Navigation

Lima menu utama: 1. Home --- dashboard. 2. Vocabulary --- seluruh
kosakata. 3. Practice --- seluruh jenis latihan. 4. Statistics ---
performa belajar. 5. Profile --- pengaturan dan akun.

### 6.7 Home Dashboard

Home harus menjawab empat pertanyaan: 1. Apa progress belajar hari ini?
2. Berapa kosakata yang perlu dipelajari? 3. Apa aktivitas selanjutnya?
4. Seberapa jauh perkembangan pengguna?

**Home sections** - Header: logo, streak, profile. - Greeting: sapaan
dan tanggal. - Daily Progress: target dan progress. - Primary CTA: mulai
atau lanjutkan belajar. - Quick Practice: akses ke latihan. - Daily
Review: kosakata yang harus diulang. - Bottom Navigation: navigasi
utama.

### 6.8 Responsive Behavior

  Device                  Width Layout
  -------------- -------------- ---------------------
  Small mobile        \< 360 px Compact
  Mobile            360--599 px Single column
  Tablet           600--1023 px Adaptive grid
  Desktop             ≥ 1024 px Sidebar + dashboard

Mobile menggunakan bottom navigation dan konten satu kolom. Desktop
menggunakan sidebar dan dashboard multi-kolom.

### 6.9 Motion Design

  Interaction       Animation
  ----------------- --------------------------
  Page transition   Fade + slight slide
  Flashcard         Flip animation
  Correct answer    Subtle success animation
  Wrong answer      Gentle shake
  Progress          Animated progress
  Button press      Slight scale down

Durasi umum 150--300 ms. Flashcard sekitar 350 ms.

## 7. Technical Requirements

### 7.1 Technology Stack

  Layer              Technology
  ------------------ ------------
  Framework          Flutter
  Language           Dart
  State Management   Riverpod
  Routing            GoRouter
  Local Database     SQLite
  Database ORM       Drift
  Backend            Supabase
  Cloud Database     PostgreSQL
  Audio              just_audio
  Charts             fl_chart

### 7.2 Architecture

``` mermaid
flowchart TB
    UI[Presentation Layer]
    STATE[Riverpod State Management]
    DOMAIN[Domain Layer]
    DATA[Data Layer]

    UI --> STATE
    STATE --> DOMAIN
    DOMAIN --> DATA

    DATA --> LOCAL[(SQLite / Drift)]
    DATA --> CLOUD[Supabase API]

    DOMAIN --> SRS[SRS Engine]
    DOMAIN --> QUIZ[Quiz Engine]
    DOMAIN --> ANALYTICS[Analytics Engine]
```

**Architecture principles** - UI tidak mengakses database secara
langsung. - Business logic ditempatkan di domain layer. - Repository
menjadi perantara data. - Database lokal menjadi sumber utama untuk
aktivitas offline. - Sinkronisasi cloud ditambahkan sebagai mekanisme
terpisah. - Supabase tidak wajib diaktifkan pada MVP personal.

## 8. Data Model --- Initial Draft

### 8.1 Vocabulary

  Field        Type   Description
  ------------ ------ -------------------------------
  id           TEXT   Primary key
  kanji        TEXT   Bentuk Kanji, nullable
  hiragana     TEXT   Cara baca
  romaji       TEXT   Romaji, nullable
  meaning      TEXT   Arti bahasa Indonesia
  word_type    TEXT   Jenis kata
  verb_group   TEXT   Kelompok kata kerja, nullable
  example_jp   TEXT   Contoh bahasa Jepang
  example_id   TEXT   Terjemahan contoh
  audio_path   TEXT   Lokasi audio, nullable
  jlpt_level   TEXT   Level JLPT

### 8.2 Learning Progress

  Field              Type      Description
  ------------------ --------- --------------------
  id                 INTEGER   Primary key
  vocabulary_id      TEXT      Foreign key
  direction          TEXT      Arah latihan
  status             TEXT      Status penguasaan
  repetitions        INTEGER   Jumlah pengulangan
  correct_count      INTEGER   Jawaban benar
  wrong_count        INTEGER   Jawaban salah
  next_review_at     TEXT      Jadwal review
  last_reviewed_at   TEXT      Review terakhir

### 8.3 Quiz Attempts

  Field           Type      Description
  --------------- --------- ------------------
  id              INTEGER   Primary key
  vocabulary_id   TEXT      Foreign key
  question_type   TEXT      Tipe soal
  user_answer     TEXT      Jawaban pengguna
  is_correct      INTEGER   Hasil jawaban
  attempted_at    TEXT      Waktu pengerjaan

### 8.4 Daily Activity

  Field                    Type      Description
  ------------------------ --------- ---------------------
  date                     TEXT      Primary key
  words_studied            INTEGER   Kosakata dipelajari
  correct_answers          INTEGER   Jawaban benar
  wrong_answers            INTEGER   Jawaban salah
  study_duration_seconds   INTEGER   Durasi belajar

> \[!warning\] Database design note Skema di atas adalah rancangan awal,
> bukan migration final. Implementasi Drift perlu migration versioning,
> indeks, constraint, dan tabel review history. Jadwal SRS dan riwayat
> review sebaiknya dipisahkan ketika algoritma SRS mulai dikembangkan.

## 9. Non-Functional Requirements

  -----------------------------------------------------------------------
  ID                      Requirement             Description
  ----------------------- ----------------------- -----------------------
  NFR-01                  Performance             Navigasi dan interaksi
                                                  terasa responsif

  NFR-02                  Offline                 Aktivitas belajar utama
                                                  berjalan tanpa internet

  NFR-03                  Persistence             Progress tidak hilang
                                                  setelah aplikasi
                                                  ditutup

  NFR-04                  Scalability             Mendukung penambahan
                                                  level N4--N1

  NFR-05                  Maintainability         Modular architecture

  NFR-06                  Accessibility           Kontras dan ukuran teks
                                                  mudah dibaca

  NFR-07                  Security                Data pengguna
                                                  terlindungi

  NFR-08                  Responsive              Mendukung berbagai
                                                  ukuran layar
  -----------------------------------------------------------------------

## 10. Acceptance Criteria

  Feature            Acceptance criteria
  ------------------ ----------------------------------------------
  Vocabulary         Kosakata dapat dicari dan difilter
  Flashcard          Kartu dapat dibalik dan hasil tersimpan
  Quiz               Jawaban dapat diperiksa dan dinilai
  Mistake Tracking   Kesalahan tercatat dengan benar
  SRS                Jadwal review diperbarui berdasarkan jawaban
  Analytics          Statistik sesuai data aktivitas
  Offline            Belajar tetap berjalan tanpa internet
  Persistence        Data tersedia setelah aplikasi restart
  Theme              Light dan Dark Mode berfungsi

## 11. Development Milestones

### Milestone 1 --- Foundation

-   [ ] Flutter project setup.
-   [ ] Theme system.
-   [ ] Design tokens.
-   [ ] Responsive navigation.
-   [ ] Home dashboard.

### Milestone 2 --- Vocabulary System

-   [ ] Database N5.
-   [ ] Vocabulary model.
-   [ ] Search dan filter.
-   [ ] Detail kosakata.
-   [ ] Furigana rendering.

### Milestone 3 --- Learning Engine

-   [ ] Flashcard.
-   [ ] Quiz engine.
-   [ ] Answer validation.
-   [ ] Mistake tracking.

### Milestone 4 --- Adaptive Learning

-   [ ] SRS algorithm.
-   [ ] Review scheduler.
-   [ ] Learning status.
-   [ ] Daily goals.

### Milestone 5 --- Analytics & Polish

-   [ ] Statistics.
-   [ ] Listening.
-   [ ] Audio pronunciation.
-   [ ] UI refinement.
-   [ ] Testing.

### Milestone 6 --- Expansion

-   [ ] Supabase.
-   [ ] Cloud synchronization.
-   [ ] Account system.
-   [ ] Multi-device support.

## 12. Out of Scope --- MVP

Fitur yang belum dibuat pada MVP: - AI tutor. - Social learning. -
Leaderboard. - Multiplayer quiz. - JLPT N4--N1. - User-generated
vocabulary. - Subscription system.

Fitur tersebut dapat masuk roadmap versi berikutnya.

## 13. Risks & Mitigation

  Risk                             Mitigation
  -------------------------------- --------------------------------------
  Database kosakata tidak akurat   Validasi sumber dan contoh kalimat
  SRS tidak efektif                Uji dengan data latihan nyata
  Progress hilang                  Persistent local database dan backup
  Sinkronisasi konflik             Versioning dan conflict resolution
  Furigana sulit ditampilkan       Rancang komponen khusus sejak awal
  Scope terlalu besar              Terapkan prioritas MVP

## 14. Definition of Done --- MVP

-   [ ] Pengguna dapat membuka dan mencari kosakata N5.
-   [ ] Pengguna dapat melakukan latihan flashcard.
-   [ ] Pengguna dapat mengerjakan quiz.
-   [ ] Jawaban benar dan salah tersimpan.
-   [ ] Sistem dapat mengidentifikasi kosakata yang lemah.
-   [ ] Sistem dapat menjadwalkan pengulangan.
-   [ ] Dashboard menampilkan statistik aktual.
-   [ ] Light dan Dark Mode berfungsi.
-   [ ] Aplikasi dapat digunakan offline.
-   [ ] Data tidak hilang setelah aplikasi ditutup.
-   [ ] Aplikasi berhasil diuji di Android dan Windows.

## 15. Open Product Decisions

Keputusan berikut perlu dikonfirmasi sebelum PRD dikunci.

### 15.1 Vocabulary Data Source

-   [ ] Database N5 yang sudah dikurasi.
-   [ ] Membuat database sendiri secara manual.
-   [ ] Import CSV / Excel.
-   [ ] Kombinasi ketiganya.

### 15.2 Answer Input

-   [ ] Multiple choice saja.
-   [ ] Typing / mengetik jawaban.
-   [ ] Keduanya.

### 15.3 User Account

-   [ ] Tanpa akun, seluruh data lokal.
-   [ ] Login dan cloud synchronization sejak awal.
-   [ ] Lokal dahulu, login ditambahkan kemudian.

> \[!tip\] Recommended defaults - Sumber kosakata: database kurasi +
> import CSV. - Sistem input: multiple choice + typing. - Akun:
> local-first, cloud synchronization pada fase berikutnya.

## 16. Next Steps

Setelah keputusan produk dikonfirmasi:

1.  Finalisasi PRD v1.0.
2.  Turunkan kebutuhan menjadi Software Requirements Specification
    (SRS).
3.  Buat implementation backlog dan task breakdown.
4.  Setup Flutter project.
5.  Implementasikan design system.
6.  Bangun MVP secara bertahap.

------------------------------------------------------------------------

## Change Log

  Version   Date         Changes
  --------- ------------ ------------------
  1.0       2026-11-08   Initial PRD draft
