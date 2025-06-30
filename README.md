# Note App

A new Flutter project.

## Getting Started

ApiService class'ında çektiğimiz verilerle ilgili bazı değişiklikler yaptım.
Bu değişiklikler şunlar: 
- fetchNotes fonksiyonu verileri çektikten sonra herhangi bir bilgi dönmüyor ve bunun yerine ValueNotifier ile oluşturulan noteListNotifier array'i ile tutuluyor.

- ValueNotifier olarak tutulan `isLoadingNotifier` ve `isErrorNotifier` bilgilerini ise yüklenme ve hata durumlarını uygulama genelinde ele almamızı sağlayan notifier'lar olarak tutuyoruz. 

State yönetimi bu şekilde daha kolay ve yönetilebilir oluyor. Kodları dikkatlice incelemenizi ve yorum satırlarını okumanızı tavsiye ediyorum.