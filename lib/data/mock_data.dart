class MockData {
  // Profile
  static const profileName = 'Alexander Sterling';
  static const profileRole = 'Verified Senior Operator';
  static const profileId = 'PS-9921-X84';
  static const activeProtekts = 12;
  static const trustScore = 99.8;
  static const rating = 4.9;
  static const totalJobs = 142;
  static const completionRate = 98;
  static const profileEmail = 'operator@protekt.elite';
  static const profilePhone = '(897) 098-7098';

  static const jobs = <Map<String, dynamic>>[
    {
      'id': 'PE-84201',
      'title': 'Upper East Side Perimeter Detail',
      'type': 'Residential Security',
      'location': 'Manhattan, NY',
      'date': 'Oct 24, 2023',
      'time': '18:00',
      'rate': 85.00,
      'status': 'completed',
      'risk': 'Medium',
    },
    {
      'id': 'PE-81199',
      'title': 'Gaia Event Close Protection',
      'type': 'Executive Protection',
      'location': 'Greenwich, CT',
      'date': 'Oct 21, 2023',
      'time': '20:00',
      'rate': 120.00,
      'status': 'completed',
      'risk': 'High',
    },
    {
      'id': 'PE-77250',
      'title': 'High-Value Asset Transit',
      'type': 'Transport Security',
      'location': 'Midtown, NY',
      'date': 'Oct 19, 2023',
      'time': '04:00',
      'rate': 95.00,
      'status': 'unserved',
      'risk': 'Critical',
    },
    {
      'id': 'PE-73100',
      'title': 'Corporate Campus Overnight',
      'type': 'Facility Watch',
      'location': 'Stamford, CT',
      'date': 'Oct 15, 2023',
      'time': '22:00',
      'rate': 70.00,
      'status': 'cancelled',
      'risk': 'Low',
    },
  ];

  static const notifications = <Map<String, dynamic>>[
    {
      'title': 'Job Unserved',
      'body':
          'Agent ID-402 failed to check-in at Sector 7 perimeter. Immediate reassignment required for Site Bravo.',
      'time': '14:23',
      'type': 'urgent',
      'hasActions': true,
    },
    {
      'title': 'Asset Movement Detected',
      'body':
          'Encrypted Hardware Vault A-04 moved outside designated geofence. Tracking active via Sentinel-Link.',
      'time': '09:15',
      'type': 'warning',
      'hasActions': false,
    },
    {
      'title': 'System Maintenance',
      'body':
          'Global firmware update v.8.2.0 scheduled for 00:00 UTC. Backup protocols will engage automatically during the window.',
      'time': '04:00',
      'type': 'info',
      'hasActions': false,
    },
    {
      'title': 'Access Granted: Executive Floor',
      'body':
          'Biometric scan verified for Director Sterling, Floor 44 access unlocked.',
      'time': 'Yesterday',
      'type': 'success',
      'hasActions': false,
    },
    {
      'title': 'Weekly Threat Assessment',
      'body':
          'Comprehensive report for Week 12 is ready for review in the dashboard analytics panel.',
      'time': 'Yesterday',
      'type': 'info',
      'hasActions': false,
    },
  ];

  static const activeInquiries = <Map<String, String>>[
    {
      'title': 'Encryption Key Re...',
      'agent': 'Agent Sarah',
      'status': 'active',
      'time': '14:02',
    },
    {
      'title': 'Node Synchroniza...',
      'agent': 'Issue resolved autom...',
      'status': 'closed',
      'time': 'Yesterday',
    },
  ];

  static const settingsItems = ['Change Password', 'App Notification', 'Delete Account'];
}
