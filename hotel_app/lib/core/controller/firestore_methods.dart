import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreMethods {
  final FirebaseFirestore _firestore;

  FirestoreMethods(this._firestore);

  // Get all hotels
  Future<List<DocumentSnapshot>> getAllHotels() async {
    QuerySnapshot snapshot = await _firestore.collection('hotels').get();
    return snapshot.docs;
  }

  // Get a specific hotel by ID
  Future<DocumentSnapshot> getHotelById(String hotelId) async {
    return await _firestore.collection('hotels').doc(hotelId).get();
  }

  // Get all rooms for a specific hotel
  Future<List<DocumentSnapshot>> getAllRoomsForHotel(String hotelId) async {
    QuerySnapshot snapshot = await _firestore
        .collection('hotels')
        .doc(hotelId)
        .collection('rooms')
        .get();
    return snapshot.docs;
  }

  Future<List<DocumentSnapshot>> getHotelsByName(String searchName) async {
    QuerySnapshot snapshot;

    if (searchName.isEmpty) {
      // Fetch all hotels if no search term is provided
      snapshot = await _firestore.collection('hotels').get();
    } else {
      // Perform a case-insensitive partial text search
      snapshot = await _firestore
          .collection('hotels')
          .where('name', isGreaterThanOrEqualTo: searchName)
          .where('name', isLessThanOrEqualTo: searchName + '\uf8ff')
          .get();
    }

    return snapshot.docs;
  }

  // Get a specific room by ID for a specific hotel
  Future<DocumentSnapshot> getRoomByIdForHotel(
      String roomId, String hotelId) async {
    return await _firestore
        .collection('hotels')
        .doc(hotelId)
        .collection('rooms')
        .doc(roomId)
        .get();
  }

//start of boking
  // Get all bookings for a specific hotel and room
  Future<List<DocumentSnapshot>> getAllBookingsForRoom(
      String hotelId, String roomId) async {
    QuerySnapshot snapshot = await _firestore
        .collection('bookings')
        .where('hotelId', isEqualTo: hotelId)
        .where('roomId', isEqualTo: roomId)
        .get();
    return snapshot.docs;
  }

  // Future<void> addBookingWithPayment(
  //   String hotelId,
  //   String roomId,
  //   String userId,
  //   DateTime checkInDate,
  //   DateTime checkOutDate, {
  //   required String cardNumber,
  //   required int expMonth,
  //   required int expYear,
  //   required String cvc,
  // }) async {
  //   // Create a new booking document
  //   DocumentReference bookingRef = _firestore.collection('bookings').doc();

  //   // Calculate the total price for the booking based on room price and duration
  //   DocumentSnapshot roomSnapshot = await _firestore
  //       .collection('hotels')
  //       .doc(hotelId)
  //       .collection('rooms')
  //       .doc(roomId)
  //       .get();
  //   // double roomPrice = roomSnapshot.data()?['price'] ?? 0.0;
  //   var roomData = roomSnapshot.data();
  //   final Map<String, dynamic> data =
  //               roomData as Map<String, dynamic>;
  //   double roomPrice = data['price'] ?? 0.0;
  //   int duration = checkOutDate.difference(checkInDate).inDays;
  //   double totalPrice = roomPrice * duration;

  //   // Create a payment intent with the Stripe API
  //   final paymentIntent = await createPaymentIntent(totalPrice);

  //   // Process the payment using the provided card details
  //   PaymentMethod paymentMethod;
  //   paymentMethod =
  //       await createPaymentMethod(cardNumber, expMonth, expYear, cvc);

  //   // Save the booking details and payment status to Firestore
  //   await bookingRef.set({
  //     'bookingId': bookingRef.id,
  //     'hotelId': hotelId,
  //     'roomId': roomId,
  //     'userId': userId,
  //     'checkInDate': Timestamp.fromDate(checkInDate),
  //     'checkOutDate': Timestamp.fromDate(checkOutDate),
  //     'paymentStatus': paymentMethod != null ? 'paid' : 'unpaid',
  //     'totalPrice': totalPrice,
  //   });

  //   // If the payment was successful, update the payment status in Firestore
  //   if (paymentIntent['status'] == 'succeeded') {
  //     await bookingRef.update({'paymentStatus': 'paid'});
  //   }
  // }

  // Future<Map<String, dynamic>> createPaymentIntent(double amount) async {
  //   // Implement your own logic to create a payment intent using the Stripe API
  //   // You can use a backend server to securely communicate with the Stripe API
  //   // and generate the payment intent on the server side
  //   // Return the payment intent details as a Map
  //   // Example:
  //   return {
  //     'status': 'succeeded',
  //     'client_secret': 'your_client_secret',
  //   };
  // }

  // Future<PaymentMethod> createPaymentMethod(
  //     String cardNumber, int expMonth, int expYear, String cvc) async {
  //   // Use the Stripe Payment SDK to create a payment method
  //   // You will need to integrate the Stripe Payment SDK in your Flutter app
  //   // This example uses the `stripe_payment` package, but you can use any other package or library
  //   StripePayment.setOptions(StripeOptions(
  //     publishableKey: 'your_publishable_key',
  //   ));

  //   final paymentMethod = PaymentMethod(
  //     card: CreditCard(
  //       number: cardNumber,
  //       expMonth: expMonth,
  //       expYear: expYear,
  //       cvc: cvc,
  //     ),
  //   );

  //   PaymentMethodToken paymentMethodToken =
  //       await StripePayment.createTokenWithCard(paymentMethod.card);
  //   if (paymentMethodToken != null && paymentMethodToken.tokenId != null) {
  //     paymentMethod.tokenId = paymentMethodToken.tokenId;
  //   }

  //   return paymentMethod;
  // }

//end of booking
  // Get all reviews for a specific hotel
  Future<List<DocumentSnapshot>> getAllReviewsForHotel(String hotelId) async {
    QuerySnapshot snapshot = await _firestore
        .collection('hotels')
        .doc(hotelId)
        .collection('reviews')
        .get();
    return snapshot.docs;
  }

  // Add a new review for a specific hotel
  Future<void> addReviewForHotel(
      String hotelId, String userId, double rating, String comment) async {
    await _firestore
        .collection('hotels')
        .doc(hotelId)
        .collection('reviews')
        .add({
      'userId': userId,
      'rating': rating,
      'comment': comment,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }
}
