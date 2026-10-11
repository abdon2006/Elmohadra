import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseConfig {
  static const String supabaseUrl = 'https://deerdvdzrrxqceovbkkj.supabase.co';
  static const String supabasePublishableKey =
      'sb_publishable_v2JJx91S0cRSBa1KaFNTwA_JT5kmPVA';
  static SupabaseClient get client => Supabase.instance.client;
}
