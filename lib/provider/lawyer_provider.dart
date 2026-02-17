import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../model/lawyer_Model.dart';
import '../services/lawyer_services.dart';

// ===============================
// Lawyer Service Provider
// ===============================
final lawyerServiceProvider = Provider((ref) => LawyerService());

// ===============================
// All Lawyers Provider
// ===============================
final allLawyersProvider = StreamProvider<List<LawyerModel>>((ref) {
  final service = ref.watch(lawyerServiceProvider);
  return service.getAllLawyers();
});

// ===============================
// Get Lawyer by ID Provider
// ===============================
final getLawyerByIdProvider = FutureProvider.family<LawyerModel?, String>((
  ref,
  lawyerId,
) async {
  final service = ref.watch(lawyerServiceProvider);
  return service.getLawyerById(lawyerId);
});

// ===============================
// Verified Lawyers Provider
// ===============================
final verifiedLawyersProvider = StreamProvider<List<LawyerModel>>((ref) {
  final service = ref.watch(lawyerServiceProvider);
  return service.getAllLawyers().map(
    (lawyers) => lawyers
        .where((lawyer) => lawyer.isApproved || lawyer.isVerified)
        .toList(),
  );
});

// ===============================
// Lawyers by Specialization Provider
// ===============================
final lawyersBySpecializationProvider =
    StreamProvider.family<List<LawyerModel>, String>((ref, specialization) {
      final service = ref.watch(lawyerServiceProvider);
      final normalized = specialization.toLowerCase().trim();
      return service.getAllLawyers().map(
        (lawyers) => lawyers
            .where(
              (lawyer) =>
                  lawyer.specialization.toLowerCase().trim() == normalized,
            )
            .toList(),
      );
    });

// ===============================
// Top Rated Lawyers Provider
// ===============================
final topRatedLawyersProvider = StreamProvider<List<LawyerModel>>((ref) {
  final service = ref.watch(lawyerServiceProvider);
  return service.getAllLawyers().map((lawyers) {
    final sorted = [...lawyers]..sort((a, b) => b.rating.compareTo(a.rating));
    return sorted;
  });
});

// ===============================
// Pending Lawyer Approvals Provider
// ===============================
final pendingLawyerApprovalsProvider = StreamProvider<List<LawyerModel>>((ref) {
  final service = ref.watch(lawyerServiceProvider);
  return service.getAllLawyers().map(
    (lawyers) => lawyers
        .where(
          (lawyer) =>
              !lawyer.isApproved ||
              lawyer.approvalStatus.toLowerCase() == 'pending',
        )
        .toList(),
  );
});

// ===============================
// Lawyer Cases Provider
// ===============================
final lawyerCasesCountProvider = FutureProvider.family<int, String>((
  ref,
  lawyerId,
) async {
  final service = ref.watch(lawyerServiceProvider);
  final lawyer = await service.getLawyerById(lawyerId);
  return lawyer?.caseIds.length ?? 0;
});

// ===============================
// Lawyer Availability Status Provider
// ===============================
final lawyerAvailabilityStatusProvider = FutureProvider.family<bool, String>((
  ref,
  lawyerId,
) async {
  final service = ref.watch(lawyerServiceProvider);
  final lawyer = await service.getLawyerById(lawyerId);
  if (lawyer == null) return false;
  return lawyer.status.toLowerCase() == 'active';
});

// ===============================
// Lawyer Notifier
// ===============================
class LawyerNotifier extends StateNotifier<LawyerModel?> {
  final LawyerService _service;

  LawyerNotifier(this._service) : super(null);

  Future<String> createLawyer(LawyerModel lawyer) async {
    await _service.addOrUpdateLawyer(lawyer);
    state = lawyer;
    return lawyer.lawyerId;
  }

  Future<void> updateLawyer(LawyerModel lawyer) async {
    await _service.updateLawyer(
      lawyerId: lawyer.lawyerId,
      data: lawyer.toJson(),
    );
    state = lawyer;
  }

  Future<void> deleteLawyer(String lawyerId) async {
    await _service.deleteLawyer(lawyerId);
    state = null;
  }

  Future<void> loadLawyer(String lawyerId) async {
    final lawyer = await _service.getLawyerById(lawyerId);
    state = lawyer;
  }

  Future<void> approveLawyer(String lawyerId) async {
    await _service.updateLawyer(
      lawyerId: lawyerId,
      data: {
        'isApproved': true,
        'approvalStatus': 'approved',
        'status': 'active',
        'isVerified': true,
      },
    );
    await loadLawyer(lawyerId);
  }

  Future<void> rejectLawyer(String lawyerId, String reason) async {
    await _service.updateLawyer(
      lawyerId: lawyerId,
      data: {
        'isApproved': false,
        'approvalStatus': 'rejected',
        'rejectionReason': reason,
        'status': 'inactive',
      },
    );
    await loadLawyer(lawyerId);
  }

  Future<void> updateRating(String lawyerId, double newRating) async {
    await _service.updateLawyer(
      lawyerId: lawyerId,
      data: {'rating': newRating},
    );
    await loadLawyer(lawyerId);
  }
}

// ===============================
// Lawyer State Notifier Provider
// ===============================
final lawyerStateNotifierProvider =
    StateNotifierProvider<LawyerNotifier, LawyerModel?>((ref) {
      final service = ref.watch(lawyerServiceProvider);
      return LawyerNotifier(service);
    });

// ===============================
// Selected Lawyer Provider
// ===============================
final selectedLawyerProvider = StateProvider<LawyerModel?>((ref) => null);
