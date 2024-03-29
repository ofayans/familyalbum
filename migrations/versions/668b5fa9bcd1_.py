"""empty message

Revision ID: 668b5fa9bcd1
Revises: a7d315c7ea73
Create Date: 2016-04-28 13:28:39.916161

"""

# revision identifiers, used by Alembic.
revision = '668b5fa9bcd1'
down_revision = 'a7d315c7ea73'

from alembic import op
import sqlalchemy as sa


def upgrade():
    ### commands auto generated by Alembic - please adjust! ###
    op.drop_constraint('users_country_id_fkey', 'users', type_='foreignkey')
    op.drop_column('users', 'sex')
    op.drop_column('users', 'country_id')
    op.drop_column('users', 'second_name')
    ### end Alembic commands ###


def downgrade():
    ### commands auto generated by Alembic - please adjust! ###
    op.add_column('users', sa.Column('second_name', sa.VARCHAR(), autoincrement=False, nullable=True))
    op.add_column('users', sa.Column('country_id', sa.VARCHAR(), autoincrement=False, nullable=True))
    op.add_column('users', sa.Column('sex', sa.VARCHAR(), autoincrement=False, nullable=True))
    op.create_foreign_key('users_country_id_fkey', 'users', 'country', ['country_id'], ['id'])
    ### end Alembic commands ###
