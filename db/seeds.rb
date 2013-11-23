# encoding: utf-8
Bank.delete_all
Bank.create!(name: 'LCL Pontoise', address:'10, place de l''Hôtel de ville 95300 Pontoise', bank_code: '30002', branch_code: '06235')
Bank.create!(name: 'Boursorama', address:'18, quai du point du jour 92100 Boulogne-Billancourt', bank_code: '30056', branch_code: '00050')
