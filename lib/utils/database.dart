class Database {
  List<String> tracks = [
    'beginners',
    'power yoga',
    'morning workout',
    'immunity booster',
    'yoga in pregnancy',
    'insomnia',
    'cardiovascular yoga',
    'yoga for migraine',
    'yoga for asthma',
  ];

  Map<String, List<Set<String>>> poses = {
    'beginners': [
      {'mountain', 'tadasana'},
      {'tree', 'vrikshasana'},
      {'downward facing dog', 'adho mukha svanasana'},
      {'triangle', 'trikonasana'},
      {'cobra', 'bhujangasana'},
      {'child', 'shishuasana'},
      {'easy', 'sukhasana'},
    ],
    'power yoga': [
      {'half moon', 'ardha chandrasana'},
      {'boat', 'paripurna navasana'},
      {'camel', 'ustrasana'},
      {'locust', 'salabhasana'},
      {'plank', 'chaturanga dandasana'},
      {'downward facing dog', 'adho mukha svanasana'},
      {'chair', 'utkatasana'}
    ],
    'morning workout': [
      {'mountain', 'tadasana'},
      {'upward salute', 'urdhva hastasana'},
      {'standing forward bend', 'hastapadasana'},
      {'low lunge', 'anjaneyasana'},
      {'plank', 'phalakasana'},
      {'four-limbed staff', 'chaturanga dandasana'},
      {'upward facing dog', 'urdhva mukha svanasana'},
      {'downward-facing dog', 'adho mukha svanasana'}
    ],
    'immunity booster': [
      {'triangle', 'trikonasana'},
      {'cobra', 'bhujangasana'},
      {'tree', 'vrikshasana'},
      {'mountain', 'tadasana'},
      {'fish', 'matsyasana'}
    ],
    'yoga in pregnancy': [
      {'mountain', 'tadasana'},
      {'triangle', 'trikonasana'},
      {'warrior', 'virabhadrasana'},
      {'easy', 'sukhasana'},
      {'cat-cow', 'marjaryasana'},
      {'forward bend', 'uttanasana'},
      {'corpse', 'shavasana'}
    ],
    'insomnia': [
      {'dynamic forward-fold sequence', 'ardha uttanasana to uttanasana'},
      {'ragdoll', 'ardha utkatasana'},
      {'downward-facing dog', 'adho mukha svanasana'},
      {'cat-cow', 'marjaryasana'},
      {'hypnotic sphinx', 'salamba bhujangasan'},
      {'seated forward bend', 'paschimottanasana'},
      {'legs-up-the-wall', 'viparita karani'},
    ],
    'cardiovascular yoga': [
      {'extended triangle', 'utthita trikonasana'},
      {'seated forward bend', 'paschimottanasana'},
      {'half spinal twist', 'ardha matsyendrasana'},
      {'cow face', 'gomukhasana'},
      {'bridge', 'setu bandhasana'}
    ],
    'yoga for migraine': [
      {'downward facing dog', 'adho mukha svanasana'},
      {'wide-legged forward bend', 'prasarita padottanasana'},
      {'child', 'shishuasana'},
      {'head to knee', 'janu sirsasana'},
      {'standing forward bend', 'hastapadasana'},
    ],
    'yoga for asthma': [
      {'easy', 'sukhasana'},
      {'staff', 'dandasana'},
      {'seated wide angle', 'upavistha konasana'},
      {'forward bend', 'uttanasana'},
      {'butterfly', 'baddha konasana'},
    ]
  };
}
